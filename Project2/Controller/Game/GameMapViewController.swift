//
//  GameMapViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/8.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class GameMapViewController: UIView {

    let firstAreaArray = [CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer()]
    let pathArray = [UIBezierPath(), UIBezierPath(), UIBezierPath()]

    var check: Bool?
    var position = 0

    override func awakeFromNib() {
        super.awakeFromNib()

        for firstArea in firstAreaArray {
            layer.addSublayer(firstArea)
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        self.clearsContextBeforeDrawing = false

        if check != nil && check! {
            creatMapStroke()
        }

    }

    func creatMapStroke() {
        switch position {
        case 0:
            self.firstAreafirstLayerStroke()
        default:
            self.fisrtAreaSecondLayerStroke()
        }
    }

    func firstAreafirstLayerStroke() {

        pathArray[0].move(to: CGPoint(x: 52 * layer.bounds.width/100, y: 90 * layer.bounds.height/100))
        pathArray[0].addLine(to: CGPoint(x: 52 * layer.bounds.width/100, y: 80 * layer.bounds.height/100))

        self.setAnimationAndLayer(layer: firstAreaArray[0], path: pathArray[0])
        position = 1

    }

    func fisrtAreaSecondLayerStroke() {

        pathArray[1].move(to: CGPoint(x: 52 * layer.bounds.width/100, y: 80 * layer.bounds.height/100))
        pathArray[1].addLine(to: CGPoint(x: 20 * layer.bounds.width/100, y: 80 * layer.bounds.height/100))
        pathArray[2].move(to: CGPoint(x: 20 * layer.bounds.width/100, y: 80 * layer.bounds.height/100))
        pathArray[2].addLine(to: CGPoint(x: 20 * layer.bounds.width/100, y: 55 * layer.bounds.height/100))

        pathArray[1].append(pathArray[2])

        self.setAnimationAndLayer(layer: firstAreaArray[1], path: pathArray[1])
        position = 2

    }

//---Setting---
    func setAnimationAndLayer(layer: CAShapeLayer, path: UIBezierPath) {

        layer.lineDashPattern = [5]
        layer.path = path.cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 4

        let baseAnimation = CABasicAnimation(keyPath: "strokeEnd")
        baseAnimation.duration = 200
        baseAnimation.fromValue = 0
        baseAnimation.toValue = 200
        layer.add(baseAnimation, forKey: nil)

    }

}
