//
//  Record.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/9.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

struct Record: Decodable {

    let trackName: String

    let artist: String?

//    let cover: [String: Any]

    let duration: Int

}

struct Album: Decodable {

    let artists: String

}
