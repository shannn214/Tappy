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
    @IBOutlet weak var leaveArrow: UIButton!

    @IBOutlet weak var smallPanel: UIView!
    @IBOutlet weak var smallTrackName: UILabel!
    @IBOutlet weak var smallPlayButton: UIButton!

    var playing = false

    override func awakeFromNib() {
        super.awakeFromNib()

        setupButton()

        setupSlider()

    }

    func setupSlider() {

        slider.setThumbImage(#imageLiteral(resourceName: "dott"), for: .normal)
        slider.addTarget(self, action: #selector(changeCurrentPosition), for: .valueChanged)

    }

    @objc func playAndPause() {

        playing = !playing

        playButton.isSelected = !playButton.isSelected

        smallPlayButton.isSelected = !smallPlayButton.isSelected

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

        if SpotifyManager.shared.haveCurrentTrack == true {

            guard let sptDuration = SpotifyManager.shared.player?.metadata.currentTrack?.duration else { return }

            let seekingCM: CMTime = CMTimeMakeWithSeconds(sptDuration, 10000)
            let duration = slider.value * Float(CMTimeGetSeconds(seekingCM))
            let newDuration = CMTimeGetSeconds(seekingCM)
            SpotifyManager.shared.player?.seek(to: Double(duration), callback: nil)

        }

    }

    private func setupButton() {

        playButton.isSelected = true

        playButton.addTarget(self, action: #selector(playAndPause), for: UIControlEvents.touchUpInside)

        smallPlayButton.addTarget(self, action: #selector(playAndPause), for: UIControlEvents.touchUpInside)

        cover.layer.cornerRadius = cover.bounds.size.width * 0.5

        leaveArrow.alpha = 0

        playButton.isSelected = false

        smallPlayButton.isSelected = false

    }

}
