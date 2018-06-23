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

    static let shared = DBProvider()

    private init() {}

    var sortedArray: Results<Track>?

    func getSortedArray() {

        do {

            let dbRealm = try Realm()
            let data = dbRealm.objects(Track.self)
            let sortedResult = data.sorted(byKeyPath: "level", ascending: true)
            sortedArray = sortedResult

        } catch let error as NSError {
            print(error)
        }

    }

}

//Need to ask Luke
extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        //        return flatMap { $0 as? T }
        let array = Array(self) as? [T]
        return array!
    }
}
