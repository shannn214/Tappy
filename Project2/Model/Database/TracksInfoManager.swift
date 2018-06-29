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

    var image: String { get }

    var hint: String { get }

    var murmur: [String] { get }

    var title: String { get }

    var content: String { get }
}

struct SpotifyUris: Codable, SpotifyUri {

    var trackUri: String

    var albumUri: String

    var level: Int

    var image: String

    var hint: String

    var murmur: [String]

    var title: String

    var content: String
}

struct SpotifyUrisManager: Codable {

    var uris: [SpotifyUris]

    init() {

        self.uris = []

    }

    enum CodingKeys: String, CodingKey {

        case uris = "datas"

    }

    static func createManagerFromFile(fileName: String = UriConstant.fileName.rawValue,
                                      fileType: String = UriConstant.fileType.rawValue) -> SpotifyUrisManager {

        let filePath = Bundle.main.path(forResource: fileName, ofType: fileType)

        let filePathURL = URL(fileURLWithPath: filePath!)

        do {

            let data = try Data(contentsOf: filePathURL, options: .mappedIfSafe)

            let jsonDecoder = JSONDecoder()

            let spotifyUrisManager = try jsonDecoder.decode(SpotifyUrisManager.self, from: data)

            return spotifyUrisManager

        } catch {

//            fatalError()
            print("Wrong file")

        }

        return SpotifyUrisManager()

    }
}

enum UriConstant: String {

    case fileName = "TracksInfo"

    case fileType = "json"

}
