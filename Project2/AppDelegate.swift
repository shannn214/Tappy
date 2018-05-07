//
//  AppDelegate.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/6.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var auth = SPTAuth()
    var authViewController = UIViewController()
    var player: SPTAudioStreamingController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.auth = SPTAuth.defaultInstance()
        self.player = SPTAudioStreamingController.sharedInstance()
        self.auth.clientID = "d030ac4b117b47ec835c425d436cb5c0"
        self.auth.redirectURL = URL(string: "project2://callback")
        self.auth.sessionUserDefaultsKey = "current session"
        self.auth.requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope, SPTAuthUserReadPrivateScope]
        self.player?.delegate = self
        
//        var audioStreamingInitError = NSError()
        DispatchQueue.main.async {
            self.startAuthenticationFlow()
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension AppDelegate: SPTAudioStreamingDelegate, SPTAudioStreamingPlaybackDelegate {

    func startAuthenticationFlow() {

        if self.auth.session != nil {
            self.player?.login(withAccessToken: self.auth.session.accessToken)
        } else {
            let authURL: URL? = self.auth.spotifyWebAuthenticationURL()
            self.authViewController = SFSafariViewController.init(url: authURL!)
            self.window?.rootViewController?.present(self.authViewController, animated: true, completion: nil)
        }

    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if self.auth.canHandle(url) {
            self.authViewController.presentingViewController?.dismiss(animated: true, completion: nil)
//            self.authViewController = nil
            self.auth.handleAuthCallback(withTriggeredAuthURL: url) { (error, session) in
                if session != nil {
                    self.player?.login(withAccessToken: self.auth.session.accessToken)
                }
            }
            return true
        }
        return false
    }
}
