//
//  HitTest.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/31.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class HitTestView: UIView {

    @IBOutlet weak var showPlayerButton: UIButton!

//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        
//        let btn_point = showPlayerButton.convert(point, from: self)
//        
//        guard showPlayerButton.point(inside: btn_point, with: event) else {
//            return super.hitTest(point, with: event)
//        }
//        return showPlayerButton
//    }

//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//
////        let hitView: UIView? = super.hitTest(point, with: event)
////
////        if self.point(inside: point, with: event) == false {
////            return nil
////        }
////
////        if hitView == self {
////            return nil
////        }
////
////        return hitView
//
//        if let result = super.hitTest(point, with: event) {
//
//            return result
//
//        }
//
//        for sub in self.subviews.reversed() {
//
//            let ptt = self.convert(point, to: sub)
//
//            if let result = sub.hitTest(ptt, with: event) {
//
//                return result
//
//            }
//
//        }
//
//        return nil
//
//    }

}
