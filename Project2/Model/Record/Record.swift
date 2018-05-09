//
//  Record.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/9.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

struct Record: Codable {

    let trackName: String

    let artist: String

    let cover: [String]

    let duration: Int

}
