//
//  SongDownloader.swift
//  Tunes
//
//  Created by Kevin Randrup on 10/31/17.
//  Copyright © 2017 Kevin Randrup. All rights reserved.
//

import Foundation

struct SongDownloader {
    
    struct SongResponse : Codable {
        let results: [Song]
        let resultCount: Int
    }
    
    static func downloadSongs(searchTerm: String, completion: @escaping ([Song]) -> Void) {
        // We need to URL-encode the search term
        let encodedTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? searchTerm
        let url = URL(string: "https://itunes.apple.com/search?term=\(encodedTerm)&entity=song")!
        
        let task: URLSessionDataTask
            = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    print(error?.localizedDescription ?? "Error making request")
                    completion([])
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                if let songResponse = try? jsonDecoder.decode(SongResponse.self, from: data) {
                    completion(songResponse.results)
                }
                
                // Manual JSON parsing
                /*
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data),
                    let typedJson = jsonObject as? [String : Any],
                    let results = typedJson["results"] as? [[String : Any]] else {
                        print("Failed json parsing")
                        completion([])
                        return
                }
                
                var songs: [Song] = []
                for songJson in results {
                    if let trackName = songJson["trackName"] as? String,
                        let artistName = songJson["artistName"] as? String,
                        let trackTimeMillis = songJson["trackTimeMillis"] as? Int,
                        let trackPrice = songJson["trackPrice"] as? Double {
                        let song = Song(trackName: trackName, artistName: artistName, trackTimeMillis: trackTimeMillis, trackPrice: trackPrice)
                        songs.append(song)
                    } else {
                        print("Failed to parse song: \(songJson)")
                    }
                }
                completion(songs)
                 */
        }
        task.resume()
    }
}
