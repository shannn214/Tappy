//
//  PlayerViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/8.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import SDWebImage

protocol PlayerDelegate: class {
    func playerViewStatus(flag: Bool)
}

class PlayerViewController: UIViewController {

    @IBOutlet weak var playerPanelView: PlayerPanelView!
    @IBOutlet weak var backgroundCover: UIImageView!

    var initialPoint: CGPoint = CGPoint(x: 0, y: 0)

    var flag: Bool = true

    var tabBarAlpha: (() -> Void)?

    weak var playerDelegate: PlayerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(trackDuration(notification:)),
            name: .startPlayingTrack,
            object: nil
        )

        setGesture()

    }

    func setGesture() {

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panPlayer(panGesture:)))

        self.view.addGestureRecognizer(panGesture)

    }

    // MARK: Notitfication
    @objc func trackDuration(notification: Notification) {

        guard let currentTrack = SpotifyManager.shared.player?.metadata.currentTrack else { return }

        guard let duration = SpotifyManager.shared.player?.metadata.currentTrack?.duration,
              let statusTime = SpotifyManager.shared.position
        else { return }

        let trackDuration = formatPlayTime(second: duration)
        playerPanelView.updateEndTime(time: trackDuration)

        let time = formatPlayTime(second: statusTime)
        playerPanelView.updateCurrentTime(currentTime: time, proportion: statusTime/duration)

        // NOTE: Try to move player data
        playerPanelView.cover.sd_setImage(with: URL(string: currentTrack.albumCoverArtURL!))
//        backgroundCover.sd_setImage(with: URL(string: currentTrack.albumCoverArtURL!))
        playerPanelView.artist.text = currentTrack.artistName
        playerPanelView.trackName.text = currentTrack.name
        playerPanelView.smallTrackName.text = currentTrack.name
        playerPanelView.playButton.isSelected = false
        playerPanelView.smallPlayButton.isSelected = false
        playerPanelView.playing = false

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

        self.playerDelegate?.playerViewStatus(flag: true)

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {

            self.view.frame = CGRect(x: 0,
                                     y: SHConstants.screenHeight - 50,
                                     width: self.view.bounds.width,
                                     height: self.view.bounds.height)

            self.playerPanelView.smallPanel.alpha = 1

            self.playerPanelView.leaveArrow.alpha = 0

        }, completion: nil)

        flag = true

    }

    @IBAction func smallLeaveArrow(_ sender: Any) {

        self.playerDelegate?.playerViewStatus(flag: false)

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {

            self.view.frame = self.view.bounds

            self.playerPanelView.smallPanel.alpha = 0

            self.playerPanelView.leaveArrow.alpha = 1

        }, completion: nil)

        flag = false

    }

    @objc func panPlayer(panGesture: UIPanGestureRecognizer) {

        let touchPoint = panGesture.location(in: self.view.window)

        let trans = panGesture.translation(in: self.view.window)

        let moving = abs(trans.y)

        guard let viewPosition = panGesture.view else { return }

        let velocity = panGesture.velocity(in: self.view.window)

        if panGesture.state == UIGestureRecognizerState.changed {

            if flag == true {

                if trans.y < 0 {

                    self.view.frame = CGRect(x: 0,
                                                  y: SHConstants.screenHeight - 50 - moving,
                                                  width: view.bounds.width,
                                                  height: view.bounds.height)

                }

            } else if flag == false {

                if touchPoint.y > 0 && trans.y > 0 {

                    self.view.frame = CGRect(x: 0,
                                                  y: trans.y,
                                                  width: view.bounds.width,
                                                  height: view.bounds.height)

                }

            }

        } else if panGesture.state == UIGestureRecognizerState.ended || panGesture.state == UIGestureRecognizerState.cancelled {

            if viewPosition.frame.origin.y < SHConstants.screenHeight / 2 || velocity.y < -1500 {

                self.playerDelegate?.playerViewStatus(flag: false)

                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {

                    self.view.frame = self.view.bounds

                    self.playerPanelView.smallPanel.alpha = 0

                    self.playerPanelView.leaveArrow.alpha = 1

                }, completion: nil)

                flag = false

            } else if viewPosition.frame.origin.y > SHConstants.screenHeight / 2 || velocity.y > 1500 {

                self.playerDelegate?.playerViewStatus(flag: true)

                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {

                    self.view.frame = CGRect(x: 0,
                                             y: SHConstants.screenHeight - 50,
                                             width: self.view.bounds.width,
                                             height: self.view.bounds.height)

                    self.playerPanelView.smallPanel.alpha = 1

                    self.playerPanelView.leaveArrow.alpha = 0

                }, completion: nil)

                flag = true

            }

        }

    }

}
