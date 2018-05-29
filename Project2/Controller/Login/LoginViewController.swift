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
    @IBOutlet weak var anonymousBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupLoginButton()
    }

    private func setupLoginButton() {
        loginSpotifyBtn.layer.cornerRadius = 20.0
        loginSpotifyBtn.tintColor = UIColor.gray
        loginSpotifyBtn.setTitleColor(UIColor.gray, for: .highlighted)
        loginSpotifyBtn.setTitle("Login with Spotify", for: .normal)

        anonymousBtn.layer.cornerRadius = 20.0
        anonymousBtn.tintColor = UIColor.gray
        anonymousBtn.setTitleColor(UIColor.gray, for: .highlighted)
        anonymousBtn.setTitle("Anonymous Login", for: .normal)
        anonymousBtn.layer.backgroundColor = UIColor.darkGray.cgColor
    }

    @IBAction func loginButton(_ sender: Any) {
        SpotifyManager.shared.startAuthenticationFlow()
    }

    @IBAction func anonymousAction(_ sender: Any) {
        DispatchQueue.main.async {
//            AppDelegate.shared?.switchToMainStoryBoard()
            let delegate = UIApplication.shared.delegate as? AppDelegate
            delegate?.window?.rootViewController = UIStoryboard.sampleStoryboard().instantiateInitialViewController()
        }
    }

}
