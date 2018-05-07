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
    }
    
    var auth = SPTAuth()
    var authViewController = UIViewController()
    var player: SPTAudioStreamingController?

}

extension LoginViewController: SPTAudioStreamingDelegate, SPTAudioStreamingPlaybackDelegate {
}
