//
//  RecordManager.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/10.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import Alamofire

protocol RecordManagerDelegate: class {
    func manager(_ manager: RecordProvider, didGet recordInfo: Record)
}

struct RecordProvider {

    weak var delegate: RecordManagerDelegate?

    var recordInfoURL = "https://api.spotify.com/v1/tracks/3V9SgblMQCt5LyepDyHyEV"

    var album: Album?

    typealias JSONStandard = [String: Any]

    func getRecordInfo() {

        guard let tokenValue = LoginManager.shared.auth.session.accessToken as? String else { return }

        let headers: HTTPHeaders = ["Authorization": "Bearer \(tokenValue)"]

        Alamofire.request(
            URL(string: recordInfoURL)!,
            method: .get,
            headers: headers
            )
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching")
                    return
                }

//                guard let json = response.result.value as? JSONStandard,
//                    let jsonResultArtist = json["artists"] as? [JSONStandard],
//                    let jsonResultAlbum = json["album"] as? JSONStandard,
//                    let jsonResultDuration = json["duration_ms"] as? String
//                    let jsonResultTrack = json["name"] as? String
//                else {
//                    print("no data")
//                    return
//                }
//
//                print("---------------")
//                print(json)
//                print(jsonResultArtist)
//                print("===============")
//                print(jsonResultAlbum)
//                print(jsonResultDuration)
//                print(jsonResultTrack)

                var recordInfo: Record?

//                guard let artist = jsonResultArtist["name"] as? String
//                    let trackName = json["name"] as? String,
//                    let cover = jsonResultAlbum["images"] as? [String : Any],
//                    let duration = json["duration_ms"] as? Int
//                    else { return }

//                recordInfo = Record(trackName: trackName, artist: nil, cover: cover, duration: duration)
//                print("---------")
//                print(recordInfo)

                DispatchQueue.main.async {
                    self.delegate?.manager(self, didGet: recordInfo!)
                }
            }

    }

}
