//
//  GameMapTestViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/22.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class GameMapTestViewController: UIViewController {

    var scrollView: UIScrollView!
    var imageView: UIImageView!
    var explosionImage: UIImageView!
    var explosionImages: [UIImage] = []

    var checkLevel = 0
    let CDButtonArray = [UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton()]
    let explosionArray = [UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView()]
    let propsButtonArray = [UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton(), UIButton()]

    let animation = CAKeyframeAnimation(keyPath: "position")
    var monster: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        createScrollViewAndMap()
        createButton()
        createCharacter()
        createPropsButton()

        setExplosionImage()
        loadButton()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showCDButton(notification:)),
            name: .leavePropPopView,
            object: nil
        )

        self.imageView.isUserInteractionEnabled = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadButton() {

        if LevelStatusManager.shared.level! > 0 {

            for level in 0...LevelStatusManager.shared.level! - 1 {
                explosionImages = createImageAnimation(total: 37, imageRefix: "Comp 1_000")

                CDButtonArray[level].isHidden = false
                explosionArray[level].isHidden = false
                animate(imageView: explosionArray[level], images: explosionImages)

            }

        }

        if LevelStatusManager.shared.level! < 10 {
            let level = LevelStatusManager.shared.level!
            propsButtonArray[level].isHidden = false
        }

    }

    func createCharacter() {

        monster = UIImageView(image: #imageLiteral(resourceName: "pink_Qghost"))
        monster.frame = CGRect(origin: CGPoint(x: 2 * imageView.bounds.width / 100,
                                               y: 72 * imageView.bounds.height/100),
                               size: CGSize(width: 70, height: 80))
        self.imageView.addSubview(monster)

    }

    func createScrollViewAndMap() {

        imageView = UIImageView(image: #imageLiteral(resourceName: "Mapkkk"))
        imageView.frame.size.height = UIScreen.main.bounds.height
        imageView.frame.size.width = UIScreen.main.bounds.height/3297 * 22041
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize = CGSize(width: imageView.bounds.width, height: UIScreen.main.bounds.height)
        scrollView.autoresizingMask = [.flexibleWidth]
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)

    }

    func createPropsButton() {

        for btnIndex in 0...9 {

            propsButtonArray[btnIndex].setImage(UIImage(), for: .normal)
            propsButtonArray[btnIndex].backgroundColor = UIColor.red
            self.imageView.addSubview(propsButtonArray[btnIndex])
            imageView.bringSubview(toFront: propsButtonArray[btnIndex])
            propsButtonArray[btnIndex].isHidden = true
            propsButtonArray[btnIndex].tag = btnIndex
            propsButtonArray[btnIndex].addTarget(self, action: #selector(showCDAndProp), for: .touchUpInside)

        }

        propsButtonArray[0].frame = CGRect(origin: CGPoint(x: 10 * imageView.bounds.width / 100,
                                                           y: 50 * imageView.bounds.height/100),
                                           size: CGSize(width: 60, height: 60))
        propsButtonArray[1].frame = CGRect(origin: CGPoint(x: 20 * imageView.bounds.width / 100,
                                                           y: 50 * imageView.bounds.height/100),
                                           size: CGSize(width: 60, height: 60))
        propsButtonArray[2].frame = CGRect(origin: CGPoint(x: 30 * imageView.bounds.width / 100,
                                                           y: 50 * imageView.bounds.height/100),
                                           size: CGSize(width: 60, height: 60))
        propsButtonArray[3].frame = CGRect(origin: CGPoint(x: 40 * imageView.bounds.width / 100,
                                                           y: 50 * imageView.bounds.height/100),
                                           size: CGSize(width: 60, height: 60))
        propsButtonArray[4].frame = CGRect(origin: CGPoint(x: 50 * imageView.bounds.width / 100,
                                                           y: 50 * imageView.bounds.height/100),
                                           size: CGSize(width: 60, height: 60))
        propsButtonArray[5].frame = CGRect(origin: CGPoint(x: 60 * imageView.bounds.width / 100,
                                                           y: 50 * imageView.bounds.height/100),
                                           size: CGSize(width: 60, height: 60))
        propsButtonArray[6].frame = CGRect(origin: CGPoint(x: 70 * imageView.bounds.width / 100,
                                                           y: 50 * imageView.bounds.height/100),
                                           size: CGSize(width: 60, height: 60))
        propsButtonArray[7].frame = CGRect(origin: CGPoint(x: 80 * imageView.bounds.width / 100,
                                                           y: 50 * imageView.bounds.height/100),
                                           size: CGSize(width: 60, height: 60))
        propsButtonArray[8].frame = CGRect(origin: CGPoint(x: 90 * imageView.bounds.width / 100,
                                                           y: 50 * imageView.bounds.height/100),
                                           size: CGSize(width: 60, height: 60))
        propsButtonArray[9].frame = CGRect(origin: CGPoint(x: 95 * imageView.bounds.width / 100,
                                                           y: 50 * imageView.bounds.height/100),
                                           size: CGSize(width: 60, height: 60))

    }

    @objc func showCDAndProp(sender: UIButton!) {

        self.checkLevel = LevelStatusManager.shared.level! + 1

        if self.checkLevel < 11 {
            LevelStatusManager.shared.updateLevel(newLevel: self.checkLevel)
        }

        let btnSendTag: UIButton = sender
        switch btnSendTag.tag {
        case 0:
            propsButtonArray[0].isHidden = true
            propsButtonArray[1].isHidden = false
            popUpView()
        case 1:
            propsButtonArray[1].isHidden = true
            propsButtonArray[2].isHidden = false
            popUpView()
        case 2:
            propsButtonArray[2].isHidden = true
            propsButtonArray[3].isHidden = false
            popUpView()
        case 3:
            propsButtonArray[3].isHidden = true
            propsButtonArray[4].isHidden = false
            popUpView()
        case 4:
            propsButtonArray[4].isHidden = true
            propsButtonArray[5].isHidden = false
            popUpView()
        case 5:
            propsButtonArray[5].isHidden = true
            propsButtonArray[6].isHidden = false
            popUpView()
        case 6:
            propsButtonArray[6].isHidden = true
            propsButtonArray[7].isHidden = false
            popUpView()
        case 7:
            propsButtonArray[7].isHidden = true
            propsButtonArray[8].isHidden = false
            popUpView()
        case 8:
            propsButtonArray[8].isHidden = true
            propsButtonArray[9].isHidden = false
            popUpView()
        case 9:
            propsButtonArray[9].isHidden = true
            popUpView()
        default:
            return
        }

    }

    func createButton() {

        for btnIndex in 0...9 {

            CDButtonArray[btnIndex].setImage(#imageLiteral(resourceName: "dark_color_record"), for: .normal)
            self.imageView.addSubview(CDButtonArray[btnIndex])
            CDButtonArray[btnIndex].isHidden = true
            CDButtonArray[btnIndex].tag = btnIndex

//            CDButtonArray[btnIndex].addTarget(self, action: #selector(showRecordInfo), for: .touchUpInside)

        }

        CDButtonArray[0].frame = CGRect(origin: CGPoint(x: 4.4 * imageView.bounds.width / 100,
                                                        y: 48 * imageView.bounds.height/100),
                                        size: CGSize(width: 60, height: 60))
        CDButtonArray[1].frame = CGRect(origin: CGPoint(x: 16 * imageView.bounds.width/100,
                                                        y: 53 * imageView.bounds.height/100),
                                        size: CGSize(width: 60, height: 60))
        CDButtonArray[2].frame = CGRect(origin: CGPoint(x: 28 * imageView.bounds.width/100,
                                                        y: 53 * imageView.bounds.height/100),
                                        size: CGSize(width: 60, height: 60))
        CDButtonArray[3].frame = CGRect(origin: CGPoint(x: 39.25 * imageView.bounds.width/100,
                                                        y: 49 * imageView.bounds.height/100),
                                        size: CGSize(width: 60, height: 60))
        CDButtonArray[4].frame = CGRect(origin: CGPoint(x: 51.75 * imageView.bounds.width/100,
                                                        y: 49 * imageView.bounds.height/100),
                                        size: CGSize(width: 60, height: 60))
        CDButtonArray[5].frame = CGRect(origin: CGPoint(x: 65.75 * imageView.bounds.width/100,
                                                        y: 49 * imageView.bounds.height/100),
                                        size: CGSize(width: 60, height: 60))
        CDButtonArray[6].frame = CGRect(origin: CGPoint(x: 80 * imageView.bounds.width/100,
                                                        y: 49 * imageView.bounds.height/100),
                                        size: CGSize(width: 60, height: 60))
        CDButtonArray[7].frame = CGRect(origin: CGPoint(x: 93.75 * imageView.bounds.width/100,
                                                        y: 49 * imageView.bounds.height/100),
                                        size: CGSize(width: 60, height: 60))
        CDButtonArray[8].frame = CGRect(origin: CGPoint(x: 98 * imageView.bounds.width/100,
                                                        y: 49 * imageView.bounds.height/100),
                                        size: CGSize(width: 60, height: 60))
        CDButtonArray[9].frame = CGRect(origin: CGPoint(x: 97 * imageView.bounds.width/100,
                                                        y: 49 * imageView.bounds.height/100),
                                        size: CGSize(width: 60, height: 60))

    }

    func setExplosionImage() {

        for explosionIndex in 0...9 {

            explosionImages = createImageAnimation(total: 37, imageRefix: "Comp 1_000")

            self.imageView.addSubview(explosionArray[explosionIndex])
            explosionArray[explosionIndex].backgroundColor = UIColor.clear
            explosionArray[explosionIndex].isHidden = true
            explosionArray[explosionIndex].tag = explosionIndex
            animate(imageView: explosionArray[explosionIndex], images: explosionImages)

            explosionArray[explosionIndex].center = CDButtonArray[explosionIndex].center
            explosionArray[explosionIndex].bounds.size = CGSize(width: 180, height: 180)

        }

    }

    @objc func showCDButton(notification: Notification) {
//    func showCDButton() {

        self.checkLevel = LevelStatusManager.shared.level!

        explosionImages = createImageAnimation(total: 37, imageRefix: "Comp 1_000")

        switch checkLevel {
        case 1:
            CDButtonArray[0].isHidden = false
            explosionArray[0].isHidden = false
            animate(imageView: explosionArray[0], images: explosionImages)
            movingAnimations(start: CGPoint(x: 2 * imageView.bounds.width/100, y: 80 * imageView.bounds.height/100),
                             end: CGPoint(x: 14 * imageView.bounds.width/100, y: 80 * imageView.bounds.height/100))
            monster.frame = CGRect(x: 14 * imageView.bounds.width/100, y: 80 * imageView.bounds.height/100,
                                   width: monster.bounds.size.width, height: monster.bounds.size.height)

        case 2:
            CDButtonArray[1].isHidden = false
            explosionArray[1].isHidden = false
            animate(imageView: explosionArray[1], images: explosionImages)
            movingAnimations(start: CGPoint(x: 14 * imageView.bounds.width/100, y: 80 * imageView.bounds.height/100),
                             end: CGPoint(x: 30 * imageView.bounds.width/100, y: 80 * imageView.bounds.height/100))

        case 3:
            CDButtonArray[2].isHidden = false
            explosionArray[2].isHidden = false
            animate(imageView: explosionArray[2], images: explosionImages)
            movingAnimations(start: CGPoint(x: 30 * imageView.bounds.width/100, y: 80 * imageView.bounds.height/100),
                             end: CGPoint(x: 40 * imageView.bounds.width/100, y: 80 * imageView.bounds.height/100))

        case 4:
            CDButtonArray[3].isHidden = false
            explosionArray[3].isHidden = false
            animate(imageView: explosionArray[3], images: explosionImages)
            movingAnimations(start: CGPoint(x: 40 * imageView.bounds.width/100, y: 80 * imageView.bounds.height/100),
                             end: CGPoint(x: 50 * imageView.bounds.width/100, y: 80 * imageView.bounds.height/100))

        case 5:
            CDButtonArray[4].isHidden = false
            explosionArray[4].isHidden = false
            animate(imageView: explosionArray[4], images: explosionImages)
            movingAnimations(start: CGPoint(x: 50 * imageView.bounds.width/100, y: 80 * imageView.bounds.height/100),
                             end: CGPoint(x: 60 * imageView.bounds.width/100, y: 80 * imageView.bounds.height/100))

        case 6:
            CDButtonArray[5].isHidden = false
            explosionArray[5].isHidden = false
            animate(imageView: explosionArray[5], images: explosionImages)
            movingAnimations(start: CGPoint(x: 60 * imageView.bounds.width/100, y: 80 * imageView.bounds.height/100),
                             end: CGPoint(x: 75 * imageView.bounds.width/100, y: 80 * imageView.bounds.height/100))

        case 7:
            CDButtonArray[6].isHidden = false
            explosionArray[6].isHidden = false
            animate(imageView: explosionArray[6], images: explosionImages)
            movingAnimations(start: CGPoint(x: 75 * imageView.bounds.width/100, y: 80 * imageView.bounds.height/100),
                             end: CGPoint(x: 85 * imageView.bounds.width/100, y: 80 * imageView.bounds.height/100))

        case 8:
            CDButtonArray[7].isHidden = false
            explosionArray[7].isHidden = false
            animate(imageView: explosionArray[7], images: explosionImages)
            movingAnimations(start: CGPoint(x: 85 * imageView.bounds.width/100, y: 80 * imageView.bounds.height/100),
                             end: CGPoint(x: 95 * imageView.bounds.width/100, y: 80 * imageView.bounds.height/100))

        case 9:
            CDButtonArray[8].isHidden = false
        default:
            CDButtonArray[9].isHidden = false
        }

    }

    // NOTE: Animation functions
    func movingAnimations(start: CGPoint, end: CGPoint) {

        let start = start
        let end = end

        animation.values = [NSValue(cgPoint: start), NSValue(cgPoint: end)]
        animation.keyTimes = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        animation.duration = 2.0
        monster.layer.add(animation, forKey: "move")

    }

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

    // NOTE: Pop Prop View
    func popUpView() {
        guard let popUpRecordView = UIStoryboard.gameStoryboard().instantiateViewController(withIdentifier: "popUpRecord") as? PopUpRecordViewController else { return }
        self.addChildViewController(popUpRecordView)
        popUpRecordView.view.frame = self.view.frame
        self.view.addSubview(popUpRecordView.view)
        popUpRecordView.view.alpha = 0
        popUpRecordView.introView.isHidden = true
        UIView.animate(withDuration: 0.2) {
            popUpRecordView.view.alpha = 1
            popUpRecordView.didMove(toParentViewController: self)
        }
    }

}
