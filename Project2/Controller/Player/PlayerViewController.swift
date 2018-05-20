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

    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBAction func leaveBtn(_ sender: Any) {
        self.dismiss(animated: true) {
        }
        SpotifyManager.shared.player?.setIsPlaying(false, callback: nil)
    }

    let designSetting = DesignSetting()

    let sortedArray = DBProvider.shared.sortedArray

    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)

    override func viewDidLoad() {
        super.viewDidLoad()

//        slider.maximumValue = Float(duration!)
//        slider.value = 0.0
//        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: false)

        cover.layer.cornerRadius = cover.bounds.size.width * 0.5

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showInfo(notification:)),
            name: .startPlayingTrack,
            object: nil
        )

    }

    @objc func showInfo(notification: NSNotification) {

//        let url = SpotifyManager.shared.player?.metadata.currentTrack?.albumCoverArtURL as? String
//        let title = SpotifyManager.shared.player?.metadata.currentTrack?.playbackSourceName
//        let artistName = SpotifyManager.shared.player?.metadata.currentTrack?.artistName
//        cover.sd_setImage(with: URL(string: url!))
//        trackName.text = title
//        artist.text = artistName

    }

    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {

        let touchPoint = sender.location(in: self.view.window)

        if sender.state == UIGestureRecognizerState.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizerState.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizerState.ended || sender.state == UIGestureRecognizerState.cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }

    func sliderProgress() {
    }

    @objc func update() {

    }
}
