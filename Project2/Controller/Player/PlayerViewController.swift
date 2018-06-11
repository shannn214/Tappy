//
//  PlayerViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/8.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import SDWebImage
import AVFoundation

class PlayerViewController: UIViewController {

    @IBOutlet weak var playerPanelView: PlayerPanelView!
    @IBOutlet weak var backgroundCover: UIImageView!

    var initialPoint: CGPoint = CGPoint(x: 0, y: 0)

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(trackDuration(notification:)),
            name: .startPlayingTrack,
            object: nil
        )

    }

    // MARK: Notitfication
    @objc func trackDuration(notification: Notification) {

        guard let duration = SpotifyManager.shared.player?.metadata.currentTrack?.duration,
              let statusTime = SpotifyManager.shared.position
        else { return }

        let trackDuration = formatPlayTime(second: duration)
        playerPanelView.updateEndTime(time: trackDuration)

        let time = formatPlayTime(second: statusTime)
        playerPanelView.updateCurrentTime(currentTime: time, proportion: statusTime/duration)

    }

    func formatPlayTime(second: TimeInterval) -> String {

        if second.isNaN {
            return "00:00"
        }
        let min = Int(second / 60)
        let sec = Int(second) % 60
        return String(format: "%02d:%02d", min, sec)

    }

    @IBAction func playButton(_ sender: Any) {

//        SpotifyManager.shared.player?.setIsPlaying(false, callback: nil)

    }

    @IBAction func leaveArrow(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {

        let touchPoint = sender.location(in: self.view.window)
        let touchTrans = sender.translation(in: self.view.window)

        if sender.state == UIGestureRecognizerState.changed {
            if touchPoint.y - initialPoint.y > 0 && touchTrans.y > 0 {
                self.view.frame = CGRect(x: 0,
                                         y: touchTrans.y,
                                         width: self.view.frame.size.width,
                                         height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizerState.ended || sender.state == UIGestureRecognizerState.cancelled {
            if touchPoint.y - initialPoint.y > 300 {
                self.dismiss(animated: true) {
                }
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0,
                                             y: 0,
                                             width: self.view.frame.size.width,
                                             height: self.view.frame.size.height)
                })
            }
        }

    }

}
