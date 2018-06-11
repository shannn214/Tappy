//
//  Constants.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/5.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

struct Constants {

    static let openingTwo = "Don't be so cold. \n Can you do me a favor?"

    static let openingThree = "Well... \n I bought a new headphone yesturday. \n But I realize that... \n I don't have music."

    static let openingFour = "So... Could you collect some record for me?"

    static let openingFive = "No >< \n If you help me, you can get... uh... \n A Toy of ME! \n YEE-HEEEE!"

    static let introText = "Yeah!!! \n I know you are a good man. \n I'll guide you to find the first record. \n \n GOGOGO!"

    static let font = "CircularStd-Medium"

    static let hint = "You found the record!"

    static let loginAlertTitle = "Notice!"

    static let loginAlterMessage = "Anonymous login will only provide game map browser mode. To access more playing mode, please login with Spotify to experience complete music colloction game."

    static let ok = "OK"

    static let cancel = "Cancel"

    static let mapSizeWidth = UIScreen.main.bounds.height/3297 * 22041

    static let screenHeight = UIScreen.main.bounds.height

    static let topViewHeight: CGFloat = 255

    static let topViewAlphaPoint: CGFloat = 190

    static let navigationBarHeight: CGFloat = 65

    static let monsterTopConstraint: CGFloat = 105

    static let mapMaskBezRect = CGRect(x: 0,
                                       y: 0,
                                       width: UIScreen.main.bounds.width,
                                       height: UIScreen.main.bounds.height)

    static let mapMaskRoundedRect = CGRect(x: 15 * UIScreen.main.bounds.width / 100,
                                           y: 68 * UIScreen.main.bounds.height / 100,
                                           width: 300,
                                           height: 150)

    static let maskCornerRadius: CGFloat = 20

    static let cardMaskBezRect = CGRect(x: 0,
                                        y: 0,
                                        width: UIScreen.main.bounds.width,
                                        height: UIScreen.main.bounds.height)

    static let cardMaskRoundedRect = CGRect(x: 10,
                                            y: 260,
                                            width: UIScreen.main.bounds.width * 0.45,
                                            height: UIScreen.main.bounds.width * 0.45)

}

struct AppColor {

    static let gradientFirst = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0).cgColor

    static let gradientSecond = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1).cgColor

    static let popUpBGColor = UIColor.black.withAlphaComponent(0.4)
}
