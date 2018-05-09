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

    override func viewDidLoad() {
        super.viewDidLoad()

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

    @objc func showInfo(notification: NSNotification) {
        let url = LoginManager.shared.player?.metadata.currentTrack?.albumCoverArtURL as? String
        recordCover.sd_setImage(with: URL(string: url!))
        let title = LoginManager.shared.player?.metadata.currentTrack?.playbackSourceName
        let artist = LoginManager.shared.player?.metadata.currentTrack?.artistName

        recordCover.sd_setImage(with: URL(string: url!))
        recordTitle.text = title
        recordArtist.text = artist
    }

    @IBAction func leaveButton(_ sender: Any) {
        LoginManager.shared.player?.setIsPlaying(false, callback: nil)
        self.view.removeFromSuperview()
    }

    func showAnimation() {
//        TO DO
    }

    func removeAnimation() {
//        TO DO
    }

}
