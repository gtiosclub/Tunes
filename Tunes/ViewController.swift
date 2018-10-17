//
//  ViewController.swift
//  Tunes2
//
//  Created by Lauren Kearley on 10/16/18.
//  Copyright © 2018 iosgatech. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UITableViewController, UISearchBarDelegate {

    var songs: [Song] = []
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.sizeToFit()
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let song = songs[indexPath.row]
        cell.textLabel?.text = "\(song.trackName) by \(song.artistName)"
        cell.detailTextLabel?.text = song.displayTrackTime
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SongDownloader.downloadSongs(searchTerm: searchBar.text!) { (songs) in
            DispatchQueue.main.async {
                self.songs = songs
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = self.songs[indexPath.row]
        let playerController = AVPlayerViewController()
        playerController.player = AVPlayer(url: URL(string: song.previewUrl)!)
        present(playerController, animated: true, completion: {
            playerController.player?.play()
        })
    }

}
