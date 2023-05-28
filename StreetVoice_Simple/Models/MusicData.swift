//
//  MusicData.swift
//  StreetVoice_Simple
//
//  Created by Jef2un_628 on 2023/5/22.
//

import Foundation
import UIKit

struct Music{
    let image: UIImage = UIImage(named: "therappers")!
    let songName: String
    let artist: String
    let album: String
    init(songName: String, artist: String, album: String) {
        self.songName = songName
        self.artist = artist
        self.album = album
    }
    
}
