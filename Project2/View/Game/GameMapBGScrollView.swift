//
//  GameMapBGScrollView.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/7.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class GameMapBGScrollView: UIScrollView {

    init(view: UIView) {
        super.init(frame: view.bounds)

        setupBGScrollView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupBGScrollView()
    }

    var backImageView: UIImageView!

    func setupBGScrollView() {

        backImageView = UIImageView(image: #imageLiteral(resourceName: "sky_map-1"))

        backImageView.frame.size = CGSize(width: Constants.mapSizeWidth,
                                          height: Constants.screenHeight)

        self.backgroundColor = UIColor.clear

        self.contentSize = CGSize(width: backImageView.bounds.width,
                                  height: Constants.screenHeight)

        self.autoresizingMask = [.flexibleWidth]

        self.addSubview(backImageView)

    }

}
