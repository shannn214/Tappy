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
    @IBAction func leaveBtn(_ sender: Any) {
//        self.dismiss(animated: true) {
//        }
        SpotifyManager.shared.player?.setIsPlaying(false, callback: nil)
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        setupButton()

        cover.layer.cornerRadius = cover.bounds.size.width * 0.5
    }

    func updateEndTime(time: String) {

        endTimeLabel.text = time

    }

    func updateCurrentTime(currentTime: String, proportion: Double) {

        startTimeLabel.text = currentTime

        slider.value = Float(proportion)

    }

    private func setupButton() {

        let pause = #imageLiteral(resourceName: "pause-2").withRenderingMode(.alwaysOriginal)
        playButton.setImage(pause, for: .selected)

    }

}
