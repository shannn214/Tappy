//
//  LoginManager.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/7.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class LoginManager: UIViewController {
    
//    static let shared = LoginManager()
//
//    private var auth = SPTAuth()
//    private var authViewController = UIViewController()
//    private var player: SPTAudioStreamingController?
//    private let clientID = "d030ac4b117b47ec835c425d436cb5c0"
//    private let redirectURL = "project2://callback"
//
//    func setup() {
//        self.auth = SPTAuth.defaultInstance()
//        self.player = SPTAudioStreamingController.sharedInstance()
//        self.auth.clientID = clientID
//        self.auth.redirectURL = URL(string: redirectURL)
//        self.auth.sessionUserDefaultsKey = "current session"
//        self.auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope, SPTAuthUserReadPrivateScope]
//        self.player?.delegate = self
//    }
//
//    func startAuthenticationFlow() {
//        if self.auth.session != nil {
//            self.player?.login(withAccessToken: self.auth.session.accessToken)
//        } else {
//            let authURL: URL? = self.auth.spotifyWebAuthenticationURL()
//            let delegate = UIApplication.shared.delegate as? AppDelegate
//            self.authViewController = SFSafariViewController.init(url: authURL!)
//            delegate?.window?.rootViewController?.present(self.authViewController,
//                                                         animated: true,
//                                                         completion: nil)
//        }
//    }

}

extension LoginManager: SPTAudioStreamingDelegate, SPTAudioStreamingPlaybackDelegate {
}
