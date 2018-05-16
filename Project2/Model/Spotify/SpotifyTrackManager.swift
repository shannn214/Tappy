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

    var trackInfo: TrackInfo?

    let token = SpotifyManager.shared.auth.session.accessToken

    func getTrackInfo(trackUri: String, albumUri: String, level: Int) {

        SPTTrack.track(withURI: URL(string: trackUri), accessToken: token, market: nil) { (error, response) in
            if response != nil {
                if let track = response as? SPTTrack, let trackArtist = track.artists as? [SPTPartialArtist] {

                    SPTAlbum.album(withURI: URL(string: albumUri), accessToken: self.token, market: nil, callback: { (error, success) in

                        print(track)
                        if success != nil {
                            if let album = success as? SPTPartialAlbum, let covers = album.covers as? [SPTImage] {
                                guard let title = track.name,
                                    let cover = album.largestCover.imageURL
//                                    let cover = covers[0].imageURL
                                    else { return }
                                let coverUri = String(describing: cover)

                                //Notice: New a place for EACH data. If u create "let databaseManager = DBManager()" outside the function, all the new data will point to the same place and edit the previous data or cause some conflict.
                                let databaseManager = DBManager()

                                var artistName = ""
                                trackArtist.forEach({ (trackArtist) in
                                    artistName += trackArtist.name + ","
                                    databaseManager.artist = artistName
                                    self.trackInfo = TrackInfo(albumCover: cover, artist: artistName, trackName: title)
                                })
                                
//                                let config = Realm.Configuration(
//
//                                    schemaVersion: 1,
//                                    migrationBlock: { migration, oldSchemaVersion in
//                                        if (oldSchemaVersion < 1) {
//                                            migration.enumerateObjects(ofType: DBManager.className()) { (_, newDBManager) in
//                                                newDBManager?["level"] = Int()
//
//                                            }
//                                        }
//                                })
//                                Realm.Configuration.defaultConfiguration = config
//                                let realm = try! Realm()

                                databaseManager.albumUri = albumUri
                                databaseManager.trackUri = trackUri
                                databaseManager.level = level
                                databaseManager.trackName = title
                                databaseManager.cover = coverUri

//                                Save Data-----
                                    do {
                                        let realm = try Realm()
                                        try realm.write {
                                            realm.add(databaseManager)
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
