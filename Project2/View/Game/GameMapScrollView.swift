//
//  GameMapScrollView.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/4.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class GameMapScrollView: UIScrollView {

    init(view: UIView) {

        super.init(frame: view.bounds)

        setupScrollView()
    }

    var mapImageView: UIImageView!

    let propsButtonArray = [UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton()]
    let CDButtonArray = [UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton()]

    func setupScrollView() {

        guard let url = Bundle.main.path(forResource: "mapppp-01", ofType: ".png") else { return }

        let image = UIImage(contentsOfFile: url)

        mapImageView = UIImageView(image: image)
        mapImageView.frame.size = CGSize(width: UIScreen.main.bounds.height/3297 * 22041, height: UIScreen.main.bounds.height)
        self.backgroundColor = UIColor.black
        self.contentSize = CGSize(width: mapImageView.bounds.width, height: UIScreen.main.bounds.height)
        self.autoresizingMask = [.flexibleWidth]
        self.addSubview(mapImageView)

    }

    func propsButtonSetup(index: Int, positionX: CGFloat, positionY: CGFloat) {

        propsButtonArray[index].frame = CGRect(origin: CGPoint(x: positionX * mapImageView.bounds.width / 100,
                                                               y: positionY * mapImageView.bounds.height/100),
                                               size: CGSize(width: 60, height: 60))

    }

    func createPropsButton() {

        for btnIndex in 0...9 {

            propsButtonArray[btnIndex].setImage(UIImage(), for: .normal)
            propsButtonArray[btnIndex].backgroundColor = UIColor.clear
            mapImageView.addSubview(propsButtonArray[btnIndex])
            mapImageView.bringSubview(toFront: propsButtonArray[btnIndex])
            propsButtonArray[btnIndex].isHidden = true
            propsButtonArray[btnIndex].tag = btnIndex
            propsButtonArray[btnIndex].addTarget(self, action: #selector(GameMapTestViewController.showCDAndProp(sender:)), for: .touchUpInside)

        }
        // NOTE: Setup props position
        propsButtonSetup(index: 0, positionX: 50, positionY: 70)
        propsButtonSetup(index: 1, positionX: 32, positionY: 53)
        propsButtonSetup(index: 2, positionX: 88, positionY: 20)
        propsButtonSetup(index: 3, positionX: 62, positionY: 40)
        propsButtonSetup(index: 4, positionX: 14.5, positionY: 4)
        propsButtonSetup(index: 5, positionX: 82.5, positionY: 71)
        propsButtonSetup(index: 6, positionX: 22, positionY: 30)
        propsButtonSetup(index: 7, positionX: 2, positionY: 77)
        propsButtonSetup(index: 8, positionX: 72, positionY: 16)
        propsButtonSetup(index: 9, positionX: 12.5, positionY: 21.4)

    }

    func createButton() {

        for btnIndex in 0...9 {

            CDButtonArray[btnIndex].setImage(#imageLiteral(resourceName: "dark_color_record"), for: .normal)
            mapImageView.addSubview(CDButtonArray[btnIndex])
            CDButtonArray[btnIndex].isHidden = true
            CDButtonArray[btnIndex].tag = btnIndex
            CDButtonArray[btnIndex].addTarget(self, action: #selector(GameMapTestViewController.showRecordTab(sender:)), for: .touchUpInside)
            CDButtonArray[btnIndex].center = propsButtonArray[btnIndex].center
            CDButtonArray[btnIndex].bounds.size = CGSize(width: 60, height: 60)

        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
