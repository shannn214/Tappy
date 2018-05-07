//
//  LoginManager.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/7.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class LoginManager: UIViewController {

    static let shared = LoginManager()

    var auth = SPTAuth.defaultInstance()!
    var authViewController = UIViewController()
    var player: SPTAudioStreamingController?
    var session: SPTSession!
    let clientID = "d030ac4b117b47ec835c425d436cb5c0"
    let redirectURL = "project2://callback"
    let delegate = UIApplication.shared.delegate as? AppDelegate

    func setup() {
        self.auth = SPTAuth.defaultInstance()
        self.player = SPTAudioStreamingController.sharedInstance()
        self.auth.clientID = clientID
        self.auth.redirectURL = URL(string: redirectURL)!
        self.auth.sessionUserDefaultsKey = "current session"
        self.auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope, SPTAuthUserReadPrivateScope]
        self.player?.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(updateAfterLogin), name: .loginSuccessfull, object: nil)
    }

    func startAuthenticationFlow() {
        if self.auth.session != nil {
            self.player?.login(withAccessToken: self.auth.session.accessToken)
            delegate?.window?.rootViewController? = UIStoryboard.mainStoryboard().instantiateInitialViewController()!
        } else {
            let authURL: URL? = self.auth.spotifyWebAuthenticationURL()
            self.authViewController = SFSafariViewController.init(url: authURL!)
            delegate?.window?.rootViewController?.present(self.authViewController,
                                                         animated: true,
                                                         completion: nil)
        }
    }

    @objc func updateAfterLogin() {
        let userDefaults = UserDefaults.standard

        if let sessionObj: AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as? Data
            let firstTimesession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj!) as? SPTSession
            self.session = firstTimesession
            initializePlayer(authSession: session!)
        }
    }

    func initializePlayer(authSession: SPTSession) {
            self.player = SPTAudioStreamingController.sharedInstance()
            self.player!.playbackDelegate = self
            self.player!.delegate = self
            try? player!.start(withClientId: auth.clientID)
            self.player!.login(withAccessToken: authSession.accessToken)
    }

    func playMusic() {
        self.player?.playSpotifyURI("spotify:track:3V9SgblMQCt5LyepDyHyEV", startingWith: 0, startingWithPosition: 0, callback: { (error) in
        })
    }

}

extension LoginManager: SPTAudioStreamingDelegate, SPTAudioStreamingPlaybackDelegate {

    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.window?.rootViewController = UIStoryboard.mainStoryboard().instantiateInitialViewController()
    }

}
