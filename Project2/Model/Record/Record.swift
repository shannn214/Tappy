//
//  Record.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/9.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

struct JSONData: Codable {

    let data: Record

}

struct Record: Codable {

    let album: Album

    let artists: String

    let duration: Int

    let name: String

    private enum CodingKeys: String, CodingKey {

        case album, artists, name

        case duration = "duration_ms"

    }

}

struct Album: Codable {

    let images: [Images]

}

struct Images: Codable {

    let url: String

}

struct RecordInfo {

    let albumCover: URL?

    let artist: String

    let trackName: String

}
