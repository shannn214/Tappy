//
//  LevelManager.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/15.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import RealmSwift

class LevelStatusManager {

    static let shared = LevelStatusManager()

    private init() {}

    let levelStatus = Level()

    var level: Int? = 0

    func initialGame() {
        createLevel(newLevel: 0)
    }

    func createLevel(newLevel: Int) {

        levelStatus.level = newLevel

        do {
            let realm = try Realm()
            try realm.write {
                realm.add(levelStatus)
            }
        } catch let error as NSError {
            print(error)
        }

    }

    func updateLevel(newLevel: Int) {

        do {
            let realm = try Realm()
            let array = realm.objects(Level.self).toArray(ofType: Level.self)
            let levelData = array[0]
            try realm.write {
                levelData.level = newLevel
            }
            level = levelData.level
        } catch let error as NSError {
            print(error)
        }

    }

    func showNewLevel() {

        do {
            let realm = try Realm()
            let array = realm.objects(Level.self).toArray(ofType: Level.self)
            let levelData = array[0]
            level = levelData.level
        } catch let error as NSError {
            print(error)
        }

    }

}
