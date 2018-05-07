//
//  LoginViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/6.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class LoginViewController: UIViewController {

    @IBOutlet weak var loginSpotifyBtn: UIButton!

    var auth = SPTAuth.defaultInstance()
    var authViewController = UIViewController()
    var player: SPTAudioStreamingController?

    var session: SPTSession!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupLoginButton()
        NotificationCenter.default.addObserver(self, selector: #selector(playSong(notification:)), name: NSNotification.Name(rawValue: "loginSuccessfull"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginManager.shared.updateAfterLogin), name: NSNotification.Name(rawValue: "loginSuccessfull"), object: nil)
    }

    private func setupLoginButton() {
        loginSpotifyBtn.layer.cornerRadius = 20.0
        loginSpotifyBtn.tintColor = UIColor.gray
        loginSpotifyBtn.setTitleColor(UIColor.gray, for: .highlighted)
        loginSpotifyBtn.setTitle("Login with Spotify", for: .normal)
    }

    @IBAction func loginButton(_ sender: Any) {
        print("PRESSSSSSS")
        LoginManager.shared.startAuthenticationFlow()
    }

    func initializePlayer(authSession: SPTSession) {
        if self.player == nil {
            self.player = SPTAudioStreamingController.sharedInstance()
            self.player!.playbackDelegate = self
            self.player!.delegate = self
            try? player!.start(withClientId: auth?.clientID)
            self.player!.login(withAccessToken: authSession.accessToken)
        }
    }

    @objc func updateAfterLogin() {
        let userDefaults = UserDefaults.standard

        if let sessionObj: AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {

            let sessionDataObj = sessionObj as? Data
            let firstTimesession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj!) as? SPTSession

            self.session = firstTimesession
            initializePlayer(authSession: session)
//            present(gameViewController, animated: true, completion: nil)
        }
    }

    @objc func playSong(notification: NSNotification) {
        self.player?.playSpotifyURI("spotify:track:1nXRacxi1isUvleBB6Jgx7", startingWith: 0, startingWithPosition: 0, callback: { (error) in
            })
    }

}

extension LoginViewController: SPTAudioStreamingDelegate, SPTAudioStreamingPlaybackDelegate {
}
