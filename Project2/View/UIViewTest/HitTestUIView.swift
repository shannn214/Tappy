//
//  HitTestUIView.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/16.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class HitTestUIView: UIView {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        return hitView == self ? nil : hitView
    }

}
