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

    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(trackDuration(notification:)),
            name: .startPlayingTrack,
            object: nil
        )

        observePlayerCurrentTime()
    }

    // MARK: Notitfication
    @objc func trackDuration(notification: Notification) {

        guard let duration = SpotifyManager.shared.player?.metadata.currentTrack?.duration else { return }
        let trackDuration = formatPlayTime(second: duration)
        playerPanelView.updateEndTime(time: trackDuration)

//        guard let state = SpotifyManager.shared.player?.playbackState.position else { return }
//        let trackState = formatPlayTime(second: state)
//        playerPanelView.updateCurrentTime(currentTime: trackState, proportion: state/duration)
        
        guard let statusTime = SpotifyManager.shared.position else { return }
        let time = formatPlayTime(second: statusTime)
        playerPanelView.updateCurrentTime(currentTime: time, proportion: statusTime/duration)

    }

    // MARK: KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {

        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)

        guard let path = keyPath,
              let change = change
        else { return }

        if path == #keyPath(PlayerPanelView.startTimeLabel) {

            playerCurrentTimeHandler(change: change)

        }

    }

    func playerCurrentTimeHandler(change: [NSKeyValueChangeKey: Any]) {

        guard let newValue = change[NSKeyValueChangeKey.newKey] as? String else { return }

        playerPanelView.updateCurrentTime(
            currentTime: newValue,
            proportion: self.currentProportion()
        )

    }

    func currentProportion() -> Double {

        guard let duration = SpotifyManager.shared.player?.metadata.currentTrack?.duration,
              let status = SpotifyManager.shared.player?.playbackState.position
        else { return 0.0 }

        let proportion = status/duration

        return proportion

    }

    func observePlayerCurrentTime() {

        playerPanelView.addObserver(
            self,
            forKeyPath: #keyPath(PlayerPanelView.startTimeLabel),
            options: NSKeyValueObservingOptions.new,
            context: nil
        )

    }
    //KVO ---end---

    func formatPlayTime(second: TimeInterval) -> String {
        if second.isNaN {
            return "00:00"
        }
        let min = Int(second / 60)
        let sec = Int(second) % 60
        return String(format: "%02d:%02d", min, sec)
    }

    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {

        let touchPoint = sender.location(in: self.view.window)
        let touchTrans = sender.translation(in: self.view.window)

        if sender.state == UIGestureRecognizerState.began {
//            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizerState.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchTrans.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizerState.ended || sender.state == UIGestureRecognizerState.cancelled {
            if touchPoint.y - initialTouchPoint.y > 200 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }

    }

}
