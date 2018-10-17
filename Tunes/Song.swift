//
//  Song.swift
//  Tunes2
//
//  Created by Lauren Kearley on 10/16/18.
//  Copyright © 2018 iosgatech. All rights reserved.
//

import Foundation

struct Song : Codable {
    let trackName: String
    let artistName: String
    let trackTimeMillis: Int
    let previewUrl: String
    
    var displayTrackTime : String {
        let seconds = trackTimeMillis / 1000
        let minutes = seconds / 60
        return String(format: "%02d:%02d", minutes, seconds % 60)
    }
}
