//
//  MaskLayer.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/7.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class MaskLayer: CAShapeLayer {

    override init() {
        super.init()
    }

    override init(layer: Any) {
        super.init(layer: layer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createMask(rect: CGRect, roundedRect: CGRect, cornerRadius: CGFloat) {

        let bezPath = UIBezierPath(rect: rect)

        let maskPath = UIBezierPath(roundedRect: roundedRect,
                                    cornerRadius: cornerRadius)

        bezPath.append(maskPath.reversing())

        self.path = bezPath.cgPath
        self.fillColor = UIColor(displayP3Red: 24/255, green: 24/255, blue: 24/255, alpha: 0.7).cgColor

    }

}
