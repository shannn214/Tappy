//
//  MapPlayerViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/26.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class MapPlayerViewController: UIViewController {

//    @IBOutlet weak var playerPanelView: PlayerPanelView!
//    @IBOutlet weak var backgroundCover: UIImageView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(trackDuration(notification:)),
//            name: .startPlayingTrack,
//            object: nil
//        )
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//    @objc func trackDuration(notification: Notification) {
//
//        guard let duration = SpotifyManager.shared.player?.metadata.currentTrack?.duration,
//            let statusTime = SpotifyManager.shared.position
//            else { return }
//
//        let trackDuration = formatPlayTime(second: duration)
//        playerPanelView.updateEndTime(time: trackDuration)
//
//        let time = formatPlayTime(second: statusTime)
//        playerPanelView.updateCurrentTime(currentTime: time, proportion: statusTime/duration)
//
//    }
//
//    func formatPlayTime(second: TimeInterval) -> String {
//
//        if second.isNaN {
//            return "00:00"
//        }
//        let min = Int(second / 60)
//        let sec = Int(second) % 60
//        return String(format: "%02d:%02d", min, sec)
//
//    }

}
