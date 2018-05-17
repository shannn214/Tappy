//
//  DBProvider.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/17.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import RealmSwift

class DBProvider {

    static var shared = DBProvider()

    var sortedArray: Results<DBManager>?

    func getSortedArray() {

        do {
            let dbRealm = try Realm()
            let data = dbRealm.objects(DBManager.self)
            let sortedResult = data.sorted(byKeyPath: "level", ascending: true)
            sortedArray = sortedResult

        } catch let error as NSError {
            print(error)
        }

    }

}
