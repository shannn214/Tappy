//
//  PlayerPanelView.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/20.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import CoreMedia

class PlayerPanelView: UIView {

    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var artist: UILabel!

    var playing = false

    override func awakeFromNib() {
        super.awakeFromNib()

        setupButton()

        cover.layer.cornerRadius = cover.bounds.size.width * 0.5

        slider.setThumbImage(#imageLiteral(resourceName: "dott"), for: .normal)

//        slider.setThumbImage(UIImage(), for: .normal)
        slider.addTarget(self, action: #selector(changeCurrentPosition), for: .touchUpInside)
        slider.addTarget(self, action: #selector(changeCurrentPosition), for: .touchUpOutside)
        slider.addTarget(self, action: #selector(changeCurrentPosition), for: .touchCancel)

        playButton.addTarget(self, action: #selector(playAndPause), for: UIControlEvents.touchUpInside)

    }

    @objc func playAndPause() {

        playing = !playing
        playButton.isSelected = !playButton.isSelected

        if playing {
            SpotifyManager.shared.player?.setIsPlaying(false, callback: nil)
        } else {
            SpotifyManager.shared.player?.setIsPlaying(true, callback: nil)
        }

    }

    func updateEndTime(time: String) {

        endTimeLabel.text = time

    }

    func updateCurrentTime(currentTime: String, proportion: Double) {

        startTimeLabel.text = currentTime

        slider.value = Float(proportion)

    }

    @objc func changeCurrentPosition() {

        let seekingCM: CMTime = CMTimeMakeWithSeconds((SpotifyManager.shared.player?.metadata.currentTrack?.duration)!, 10000)
        let duration = slider.value * Float(CMTimeGetSeconds(seekingCM))
        let newDuration = CMTimeGetSeconds(seekingCM)
//        let seekTime = CMTimeMake(Int64(duration), 1)
        SpotifyManager.shared.player?.seek(to: Double(duration), callback: nil)

        let value = slider.value

    }

    private func setupButton() {

        playButton.isSelected = true

    }

}
