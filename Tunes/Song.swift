//
//  Song.swift
//  Tunes
//
//  Created by Kevin Randrup on 10/31/17.
//  Copyright © 2017 Kevin Randrup. All rights reserved.
//

import Foundation

struct Song : Codable {
    let trackName: String
    let artistName: String
    let trackTimeMillis: Int
    let trackPrice: Double
    
    var displayTrackTime: String {
        let seconds = trackTimeMillis / 1000
        let minutes = seconds / 60
        return String(format: "%02d:%02d", minutes, seconds % 60)
    }
}
