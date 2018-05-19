//
//  UIStoryboard.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/6.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

extension UIStoryboard {

    static func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

    static func loginStorybaord() -> UIStoryboard {
        return UIStoryboard(name: "Login", bundle: nil)
    }

    static func gameStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Game", bundle: nil)
    }

    static func collectionStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Collection", bundle: nil)
    }

    static func cardStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Card", bundle: nil)
    }

    static func settingStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Setting", bundle: nil)
    }

    static func playerStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Player", bundle: nil)
    }

}
