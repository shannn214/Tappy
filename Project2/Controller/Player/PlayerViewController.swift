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

    let designSetting = DesignSetting()

    override func viewDidLoad() {
        super.viewDidLoad()

//        slider.maximumValue = Float(duration!)
//        slider.value = 0.0
//        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: false)

        let url = LoginManager.shared.player?.metadata.currentTrack?.albumCoverArtURL as? String
        let title = LoginManager.shared.player?.metadata.currentTrack?.playbackSourceName
        let artistName = LoginManager.shared.player?.metadata.currentTrack?.artistName
        cover.sd_setImage(with: URL(string: url!))
        trackName.text = title
        artist.text = artistName
        designSetting.designSetting(view: cover)
    }

    func sliderProgress() {
    }

    @objc func update() {

    }
}
