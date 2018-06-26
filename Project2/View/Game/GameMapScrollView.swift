//
//  GameMapScrollView.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/4.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

protocol GameMapScrollDelegate: class {

    func propButtonDidTap(_ controller: GameMapScrollView, sender: UIButton!)

    func CDButtonDidTap(_ controller: GameMapScrollView, sender: UIButton!)

    func monsterDidTap(_ controller: GameMapScrollView, tapGestureRecognizer: UITapGestureRecognizer)

}

class GameMapScrollView: UIScrollView {

    init(view: UIView) {
        super.init(frame: view.bounds)

        setupScrollView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupScrollView()
    }

    weak var tapDelegate: GameMapScrollDelegate?

    var mapImageView: UIImageView!
    var monster: UIImageView!
    var explosionImages: [UIImage] = []

    let propsButtonArray = [UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton()]
    let CDButtonArray = [UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton()]
    let explosionArray = [UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView()]

    private func setupScrollView() {

        mapImageView = UIImageView(image: #imageLiteral(resourceName: "ground_map-1"))
        mapImageView.frame.size = CGSize(width: (UIScreen.main.bounds.height - 50)/3297 * 22041,
                                         height: UIScreen.main.bounds.height - 50)
        self.backgroundColor = UIColor.clear
        self.contentSize = CGSize(width: mapImageView.bounds.width,
                                  height: SHConstants.screenHeight)
        self.autoresizingMask = [.flexibleWidth]
        self.addSubview(mapImageView)
        mapImageView.isUserInteractionEnabled = true

        createPropsButton()
        createButton()
        setExplosionImage()
        createCharacter()

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
            propsButtonArray[btnIndex].addTarget(self, action: #selector(propBtnDidTap(sender:)), for: .touchUpInside)

        }
        // NOTE: Setup props position
        propsButtonSetup(index: 0, positionX: 50, positionY: 70)
        propsButtonSetup(index: 1, positionX: 32, positionY: 53)
        propsButtonSetup(index: 2, positionX: 86, positionY: 20)
        propsButtonSetup(index: 3, positionX: 62, positionY: 40)
        propsButtonSetup(index: 4, positionX: 20, positionY: 4)
        propsButtonSetup(index: 5, positionX: 82.5, positionY: 71)
        propsButtonSetup(index: 6, positionX: 8, positionY: 28)
        propsButtonSetup(index: 7, positionX: 2, positionY: 77)
        propsButtonSetup(index: 8, positionX: 72, positionY: 16)
        propsButtonSetup(index: 9, positionX: 98, positionY: 25)

    }

    @objc func propBtnDidTap(sender: UIButton!) {
        self.tapDelegate?.propButtonDidTap(self, sender: sender)
    }

    func createButton() {

        for btnIndex in 0...9 {

            CDButtonArray[btnIndex].setImage(#imageLiteral(resourceName: "dark_color_record"), for: .normal)
            mapImageView.addSubview(CDButtonArray[btnIndex])
            CDButtonArray[btnIndex].isHidden = true
            CDButtonArray[btnIndex].tag = btnIndex
            CDButtonArray[btnIndex].addTarget(self, action: #selector(CDButtonDidTap(sender:)), for: .touchUpInside)
            CDButtonArray[btnIndex].center = propsButtonArray[btnIndex].center
            CDButtonArray[btnIndex].bounds.size = CGSize(width: 60, height: 60)

        }

    }

    @objc func CDButtonDidTap(sender: UIButton!) {

        self.tapDelegate?.CDButtonDidTap(self, sender: sender)

    }

    func setExplosionImage() {

        for explosionIndex in 0...9 {

            explosionImages = createImageAnimation(total: 37, imageRefix: "Comp 1_000")

            mapImageView.addSubview(explosionArray[explosionIndex])
            explosionArray[explosionIndex].backgroundColor = UIColor.clear
            explosionArray[explosionIndex].isHidden = true
            explosionArray[explosionIndex].tag = explosionIndex
            animate(imageView: explosionArray[explosionIndex], images: explosionImages)

            explosionArray[explosionIndex].center = CDButtonArray[explosionIndex].center
            explosionArray[explosionIndex].bounds.size = CGSize(width: 180, height: 180)

        }

    }

    func createCharacter() {

        monster = UIImageView()
        monster.image = #imageLiteral(resourceName: "right_pink")
        monster.frame = CGRect(x: 2 * mapImageView.bounds.width / 100,
                               y: 77 * mapImageView.bounds.height/100, width: 75, height: 62)

        mapImageView.addSubview(monster)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(monsterImageDidTap(tapGestureRecognizer:)))
        monster.isUserInteractionEnabled = true
        monster.addGestureRecognizer(tapGestureRecognizer)

    }

    @objc func monsterImageDidTap(tapGestureRecognizer: UITapGestureRecognizer) {

        self.tapDelegate?.monsterDidTap(self, tapGestureRecognizer: tapGestureRecognizer)

    }

    // Animation
    func createImageAnimation(total: Int, imageRefix: String) -> [UIImage] {

        var imageArray: [UIImage] = []

        for imageCount in 10..<total {
            let imageName = "\(imageRefix)\(imageCount).png"
            let image = UIImage(named: imageName)!

            imageArray.append(image)
        }

        return imageArray

    }

    func animate(imageView: UIImageView, images: [UIImage]) {

        imageView.animationImages = images
        imageView.animationDuration = 0.8
        imageView.animationRepeatCount = 0
        imageView.startAnimating()

    }

}
