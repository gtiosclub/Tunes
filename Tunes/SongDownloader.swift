//
//  SongDownloader.swift
//  Tunes2
//
//  Created by Lauren Kearley on 10/16/18.
//  Copyright © 2018 iosgatech. All rights reserved.
//

import Foundation

struct SongDownloader {
    
    struct SongResponse : Codable {
        let results : [Song]
        let resultCount : Int
    }
    
    static func downloadSongs(searchTerm: String, completion: @escaping ([Song]) -> Void) {
        let encodedTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? searchTerm
        let url = URL(string: "https://itunes.apple.com/search?term=\(encodedTerm)&entity=song")!
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "error")
                completion([])
                return
            }
            let jsonDecoder = JSONDecoder()
            if let songResponse = try?
                jsonDecoder.decode(SongResponse.self, from: data) {
                completion(songResponse.results)
            }
            
        }
        task.resume()
        
    }
}
