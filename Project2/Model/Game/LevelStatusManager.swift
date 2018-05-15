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

    static var shared = LevelStatusManager()

    let levelStatus = LevelManager()

    var level: Int? = 0

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
            let array = realm.objects(LevelManager.self).toArray(ofType: LevelManager.self)
            let levelData = array[0]
            try realm.write {
                levelData.level = newLevel
            }
        } catch let error as NSError {
            print(error)
        }

    }

    func showNewLevel() {

        do {
            let realm = try Realm()
            let array = realm.objects(LevelManager.self).toArray(ofType: LevelManager.self)
            let levelData = array[0]
            level = levelData.level
        } catch let error as NSError {
            print(error)
        }

    }

}
