//
//  TracksInfoManager.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/14.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

protocol SpotifyUri {

    var trackUri: String { get }

    var albumUri: String { get }

    var level: Int { get }
}

struct SpotifyUris: Codable, SpotifyUri {

    var trackUri: String

    var albumUri: String

    var level: Int

}

struct SpotifyUrisManager: Codable {

    var uris: [SpotifyUris]

    enum CodingKeys: String, CodingKey {

        case uris = "datas"

    }

    static func createManagerFromFile() -> SpotifyUrisManager {

        let filePath = Bundle.main.path(forResource: UriConstant.fileName.rawValue, ofType: UriConstant.fileType.rawValue)

        let filePathURL = URL(fileURLWithPath: filePath!)

        do {

            let data = try Data(contentsOf: filePathURL, options: .mappedIfSafe)

            let jsonDecoder = JSONDecoder()

            let spotifyUrisManager = try jsonDecoder.decode(SpotifyUrisManager.self, from: data)

            return spotifyUrisManager

        } catch {

            fatalError()

        }

    }
}

enum UriConstant: String {

    case fileName = "TracksInfo"

    case fileType = "json"

}
