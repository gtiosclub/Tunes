//
//  ViewController.swift
//  Tunes2
//
//  Created by Lauren Kearley on 10/16/18.
//  Copyright © 2018 iosgatech. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UITableViewController, UISearchResultsUpdating {
    
    var songs: [Song] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
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
    
    func updateSearchResults(for searchController: UISearchController) {
        if let query = searchController.searchBar.text {
            SongDownloader.downloadSongs(searchTerm: query) { (songs) in
                DispatchQueue.main.async {
                    self.songs = songs
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = self.songs[indexPath.row]
        let playerController = AVPlayerViewController()
        playerController.player = AVPlayer(url: URL(string: song.previewUrl)!)
        if let imageData = NSData(contentsOf: (URL(string: song.artworkUrl100)!)) {
            let imageView = UIImageView(image: UIImage(data: imageData as Data))
            imageView.center = playerController.view.center
            playerController.contentOverlayView?.addSubview(imageView)
        }
        present(playerController, animated: true, completion: {
            playerController.player?.play()
        })
    }
    
}
