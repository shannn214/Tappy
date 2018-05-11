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

                if let result = response.result.value {
                    let JSON = result as? NSDictionary
                    
                    do {
                        let recordInfo = try JSONDecoder().decode(Record.self, from: response.data!)
                        print(recordInfo)
                    } catch {
                        print(error)
                    }

                }

//                var getRecordInfo: Record?
//                let dictionary = ["data": response]
//                if let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) {
//                    if let recordInfo = try? JSONDecoder().decode(JSONData.self, from: jsonData).data {
//                        print(recordInfo)
//
//                        let artists = recordInfo.artists
//                        let duration = recordInfo.duration
//                        let name = recordInfo.name
//                        let cover = recordInfo.album.images[1].url
//
//                        getRecordInfo = Record(album: Album(images: [Images(url: cover)]), artists: artists, duration: duration, name: name)
//
//                        DispatchQueue.main.async {
//                            self.delegate?.manager(self, didGet: getRecordInfo!)
//                        }
//                    }
//                }

            }
    }

}
