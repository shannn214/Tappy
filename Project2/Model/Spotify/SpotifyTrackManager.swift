//
//  SpotifyTrackManager.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/13.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import RealmSwift

protocol SpotifyTrackManagerDelegate: class {
    func trackManager(trackInfo: TrackInfo)
}

class SpotifyTrackManager {

    weak var delegate: SpotifyTrackManagerDelegate?

    var trackInfo: TrackInfo?

    var databaseManager = DBManager()

    let token = SpotifyManager.shared.auth.session.accessToken

    func getTrackInfo(trackUri: String, albumUri: String) {

        SPTTrack.track(withURI: URL(string: trackUri), accessToken: token, market: nil) { (error, response) in
            if response != nil {
                if let track = response as? SPTTrack, let trackArtist = track.artists as? [SPTPartialArtist] {

                    SPTAlbum.album(withURI: URL(string: albumUri), accessToken: self.token, market: nil, callback: { (error, success) in

                        if success != nil {
                            if let album = success as? SPTPartialAlbum, let covers = album.covers as? [SPTImage] {
                                guard let title = track.name,
                                    let cover = album.largestCover.imageURL
//                                    let cover = covers[0].imageURL
                                    else { return }

                                var artistName = ""
                                trackArtist.forEach({ (trackArtist) in
                                    artistName += trackArtist.name

                                    self.databaseManager.artist = artistName

                                    self.trackInfo = TrackInfo(albumCover: cover, artist: artistName, trackName: title)
                                })

                                self.databaseManager.albumUri = albumUri
                                self.databaseManager.trackUri = trackUri
                                self.databaseManager.trackName = title
                                self.databaseManager.cover = "Cover"

//                                Save Data-----
                                do {
                                    let realm = try Realm()
                                    try realm.write {
                                        realm.add(self.databaseManager)
                                    }
                                } catch let error as NSError {
                                    print(error)
                                }
                                
//                                Delete All Data----
//                                do {
//                                    let realm = try Realm()
//                                    try realm.write {
//                                        realm.deleteAll()
//                                    }
//                                } catch let error as NSError {
//                                    print(error)
//                                }

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
