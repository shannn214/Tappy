//
//  Project2Tests.swift
//  Project2Tests
//
//  Created by 尚靖 on 2018/6/13.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import XCTest
@testable import Project2

class Project2Tests: XCTestCase {

    var spotifyManager: SpotifyUrisManager!

    override func setUp() {
        super.setUp()

        spotifyManager = SpotifyUrisManager()

    }

    override func tearDown() {

        spotifyManager = nil

        super.tearDown()
    }

    func testExample() {

        let ssss = SpotifyUrisManager.createManagerFromFile(fileName: UriConstant.fileName.rawValue,
                                                            fileType: UriConstant.fileType.rawValue)

        XCTAssertEqual(ssss.uris.count, 10)

    }

}
