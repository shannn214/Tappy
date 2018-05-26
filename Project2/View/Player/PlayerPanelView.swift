//
//  PlayerPanelView.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/20.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

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

        // TODO
        slider.setThumbImage(UIImage(), for: .normal)

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

    private func setupButton() {

        playButton.isSelected = true

    }

}
