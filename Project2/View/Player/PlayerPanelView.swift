//
//  PlayerPanelView.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/20.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class PlayerPanelView: UIView {

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

        cover.layer.cornerRadius = cover.bounds.size.width * 0.5
    }

    @objc func showInfo(notification: NSNotification) {

        //        let url = SpotifyManager.shared.player?.metadata.currentTrack?.albumCoverArtURL as? String
        //        let title = SpotifyManager.shared.player?.metadata.currentTrack?.playbackSourceName
        //        let artistName = SpotifyManager.shared.player?.metadata.currentTrack?.artistName
        //        cover.sd_setImage(with: URL(string: url!))
        //        trackName.text = title
        //        artist.text = artistName

    }

}
