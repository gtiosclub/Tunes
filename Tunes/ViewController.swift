//
//  ViewController.swift
//  Tunes
//
//  Created by Kevin Randrup on 10/31/17.
//  Copyright © 2017 Kevin Randrup. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var songs: [Song] = [
        Song(trackName: "Run the World (Girls)", artistName: "Beyoncé", trackTimeMillis: 238305, trackPrice: 1.29)
    ]
    // BONUS: Search bar
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Uncomment without the search bar
        /*
        SongDownloader.downloadSongs(searchTerm: "Boyoncé") { (songs) in
            DispatchQueue.main.async {
                self.songs = songs
                self.tableView.reloadData()
            }
        }
        */
        
        // BONUS: Search bar
        searchBar.sizeToFit()
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let CELL_ID = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID) ??
            UITableViewCell(style: .subtitle, reuseIdentifier: CELL_ID)
        
        let song = songs[indexPath.row]
        cell.textLabel?.text = "\(song.trackName) by \(song.artistName)"
        cell.detailTextLabel?.text = "\(song.displayTrackTime) for just $\(song.trackPrice)"
        
        return cell
    }
}

// BONUS: Search bar
extension ViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SongDownloader.downloadSongs(searchTerm: searchBar.text!) { (songs) in
            DispatchQueue.main.async {
                self.songs = songs
                self.tableView.reloadData()
            }
        }
    }
}
