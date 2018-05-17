//
//  TrackModel.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/14.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import RealmSwift

class DBManager: Object {

    @objc dynamic var trackUri = ""
    @objc dynamic var albumUri = ""
    @objc dynamic var trackName = ""
    @objc dynamic var artist = ""
    @objc dynamic var cover = ""
    @objc dynamic var level = Int()

}

class LevelManager: Object {

    @objc dynamic var level: Int = 0

}
