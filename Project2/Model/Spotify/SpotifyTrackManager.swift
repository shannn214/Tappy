//
//  SpotifyTrackManager.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/13.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

protocol SpotifyTrackManagerDelegate: class {
    func trackManager(trackInfo: TrackInfo)
}

class SpotifyTrackManager {

    weak var delegate: SpotifyTrackManagerDelegate?

    var trackInfo: TrackInfo?

    let token = SpotifyManager.shared.auth.session.accessToken

    func getTrackInfo(trackUri: String, albumUri: String) {

        SPTTrack.track(withURI: URL(string: trackUri), accessToken: token, market: nil) { (error, response) in
            if response != nil {
                if let track = response as? SPTTrack, let trackArtist = track.artists as? [SPTPartialArtist] {

                    SPTAlbum.album(withURI: URL(string: albumUri), accessToken: self.token, market: nil, callback: { (error, success) in

                        if success != nil {
                            if let album = success as? SPTPartialAlbum {
                                guard let name = trackArtist[0].name,
                                    let title = track.name,
                                    let cover = album.largestCover.imageURL
                                    else { return }

                                self.trackInfo = TrackInfo(albumCover: cover, artist: name, trackName: title)

                                DispatchQueue.main.async {
                                    self.delegate?.trackManager(trackInfo: self.trackInfo!)
                                }
                            }
                        } else {
                            print(error)
                        }
                    })

                }
            } else {
                print(error)
            }
        }

    }

}
