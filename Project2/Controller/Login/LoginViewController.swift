//
//  LoginViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/6.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class LoginViewController: UIViewController {
    
    @IBAction func loginButton(_ sender: Any) {
//            LoginManager.shared.startAuthenticationFlow()
    }
    
    @IBOutlet weak var loginSpotifyBtn: UIButton!

    var auth = SPTAuth()
    var authViewController = UIViewController()
    var player: SPTAudioStreamingController?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupLoginButton()
//        LoginManager.shared.setup()
    }

    private func setupLoginButton() {
        loginSpotifyBtn.layer.cornerRadius = 20.0
        loginSpotifyBtn.tintColor = UIColor.gray
        loginSpotifyBtn.setTitleColor(UIColor.gray, for: .highlighted)
        loginSpotifyBtn.setTitle("Login with Spotify", for: .normal)
    }

}

extension LoginViewController: SPTAudioStreamingDelegate, SPTAudioStreamingPlaybackDelegate {
}
