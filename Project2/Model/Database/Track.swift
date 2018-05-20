//
//  TrackModel.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/14.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import RealmSwift

class Track: Object {

    @objc dynamic var trackUri = ""
    @objc dynamic var albumUri = ""
    @objc dynamic var trackName = ""
    @objc dynamic var artist = ""
    @objc dynamic var cover = ""
    @objc dynamic var level = Int()

    static func createTrack(track: String,
                            album: String,
                            name: String,
                            artist: String,
                            cover: String,
                            level: Int
                            ) -> Object {

                                    let trackObject = Track()
                                    trackObject.trackUri = track
                                    trackObject.albumUri = album
                                    trackObject.trackName = name
                                    trackObject.artist = artist
                                    trackObject.cover = cover
                                    trackObject.level = level

                                    return trackObject

    }

}

class Level: Object {

    @objc dynamic var level: Int = 0

}
