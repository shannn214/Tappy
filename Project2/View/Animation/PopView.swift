//
//  PopView.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/23.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class PopView: UIView {

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))

        isUserInteractionEnabled = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.07, execute: {
            for number in 1...6 {
                let line = Line()
                line.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                line.transform = CATransform3DMakeRotation(CGFloat.pi * 2 / CGFloat(6) * CGFloat(number), 0, 0, 1)
                self.layer.addSublayer(line)
                line.animate()
            }
        })

        let minOffset: UInt32 = 0
        let maxOffset: UInt32 = 200
        let rotation = CGFloat(arc4random_uniform(maxOffset - minOffset) + minOffset) / CGFloat(100)
        transform = CGAffineTransform(rotationAngle: rotation)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
