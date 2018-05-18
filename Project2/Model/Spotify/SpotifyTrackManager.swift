//
//  SpotifyTrackManager.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/13.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import RealmSwift

class SpotifyTrackManager {

    static let shared = SpotifyTrackManager()

    private init() {}

    let token = SpotifyManager.shared.auth.session.accessToken

    func getTrackInfo(trackUri: String, albumUri: String, level: Int) {

        SPTTrack.track(
            withURI: URL(string: trackUri),
            accessToken: token,
            market: nil
            ) { (error, response) in

                guard let track = response as? SPTTrack,
                      let trackArtist = track.artists as? [SPTPartialArtist]
                else { return }

                SPTAlbum.album(
                    withURI: URL(string: albumUri),
                    accessToken: self.token,
                    market: nil,
                    callback: { [weak self] (error, data) in

                        guard data != nil,
                              let album = data as? SPTPartialAlbum,
                              let covers = album.covers as? [SPTImage],
                              let title = track.name,
                              let cover = album.largestCover.imageURL
                        else { return }

                        let coverUri = String(describing: cover)

                        var artistName = ""

                        trackArtist.forEach({ (trackArtist) in
                            artistName += trackArtist.name + ","
                        })

                        let track = Track.createTrack(track: trackUri,
                                                      album: albumUri,
                                                      name: title,
                                                      artist: artistName,
                                                      cover: coverUri,
                                                      level: level)

                        do {
                            let realm = try Realm()
                            try realm.write {
                                realm.add(track)
                            }
                        } catch let error as NSError {
                            print(error)
                        }

                })
        }

    }

}
