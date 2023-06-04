//
//  AuthManager.swift
//  FinalProject
//
//  Created by Jef2un_628 on 2023/6/4.
//

import Foundation

final class ShareManager{
    static let shared = ShareManager()
    
    public var isSignIn: Bool = false
    
    public var isMusicPlaying: Bool = false {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name("musicPlayingChanged"), object: nil)
        }
    }
    
}

//                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)

