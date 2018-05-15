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

//    func save() {
//        do {
//            let realm = try Realm()
//            try realm.write {
//                realm.add(self, update: true)
//            }
//        } catch let error as NSError {
//            fatalError(error.localizedDescription)
//        }
//    }

}

class LevelManager: Object {

    @objc dynamic var level: Int = 0

}
