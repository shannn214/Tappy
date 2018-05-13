//
//  PopUpRecordViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/8.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit
import SDWebImage

class PopUpRecordViewController: UIViewController {

    @IBOutlet weak var recordCover: UIImageView!
    @IBOutlet weak var recordTitle: UILabel!
    @IBOutlet weak var recordArtist: UILabel!

    var auth = SPTAuth.defaultInstance()!
    var session: SPTSession!
    var player: SPTAudioStreamingController?

    weak var delegate = UIApplication.shared.delegate as? AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        recordCover.alpha = 0

        let tap = UITapGestureRecognizer(target: self, action: #selector(touchCover))
        recordCover.isUserInteractionEnabled = true
        recordCover.addGestureRecognizer(tap)

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        NotificationCenter.default.addObserver(self, selector: #selector(showInfo(notification:)), name: .startPlayingTrack, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    @objc func touchCover() {
        delegate?.window?.rootViewController = UIStoryboard.playerStoryboard().instantiateInitialViewController()
    }

    @objc func showInfo(notification: NSNotification) {
        let url = SpotifyManager.shared.player?.metadata.currentTrack?.albumCoverArtURL as? String
        let title = SpotifyManager.shared.player?.metadata.currentTrack?.playbackSourceName
        let artist = SpotifyManager.shared.player?.metadata.currentTrack?.artistName

        UIView.animate(withDuration: 0.2) {
            self.recordCover.alpha = 1
        }
        recordCover.sd_setImage(with: URL(string: url!))
        recordTitle.text = title
        recordArtist.text = artist
        rotate(image: recordCover)
    }

    @IBAction func leaveButton(_ sender: Any) {
        SpotifyManager.shared.player?.setIsPlaying(false, callback: nil)

        self.view.removeFromSuperview()
    }

    func showAnimation() {
//        TO DO
    }

    func removeAnimation() {
//        TO DO
    }

//    Animation
    func rotate(image: UIImageView) {
        let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: .pi * 2.0)
        rotationAnimation.duration = 10
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = .infinity
        image.layer.add(rotationAnimation, forKey: "rotationAnimation")
        image.layer.cornerRadius = self.recordCover.bounds.size.width * 0.5
    }

}
