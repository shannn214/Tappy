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
    var monsterImages: [UIImage] = []

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

        monster = UIImageView()
        monsterImages = createImageAnimationForGhost(total: 2, imageRefix: "peek_ghost")
        animate(imageView: monster, images: monsterImages)
        monster.frame = CGRect(x: 2 * imageView.bounds.width / 100, y: 73 * imageView.bounds.height/100, width: 70, height: 70)
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
    
    func propsButtonSetup(index: Int, positionX: CGFloat, positionY: CGFloat) {
        
        propsButtonArray[index].frame = CGRect(origin: CGPoint(x: positionX * imageView.bounds.width / 100,
                                                               y: positionY * imageView.bounds.height/100),
                                               size: CGSize(width: 60, height: 60))
        
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
        
        propsButtonSetup(index: 0, positionX: 10, positionY: 50)
        propsButtonSetup(index: 1, positionX: 20, positionY: 50)
        propsButtonSetup(index: 2, positionX: 30, positionY: 50)
        propsButtonSetup(index: 3, positionX: 40, positionY: 50)
        propsButtonSetup(index: 4, positionX: 50, positionY: 50)
        propsButtonSetup(index: 5, positionX: 60, positionY: 50)
        propsButtonSetup(index: 6, positionX: 70, positionY: 50)
        propsButtonSetup(index: 7, positionX: 80, positionY: 50)
        propsButtonSetup(index: 8, positionX: 87.5, positionY: 46.4)
        propsButtonSetup(index: 9, positionX: 12.5, positionY: 21.4)

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
    
    func CDButtonSetup(index: Int, positionX: CGFloat, positionY: CGFloat) {
        
        CDButtonArray[index].frame = CGRect(origin: CGPoint(x: positionX * imageView.bounds.width / 100,
                                                            y: positionY * imageView.bounds.height/100),
                                            size: CGSize(width: 60, height: 60))
        
    }

    func createButton() {

        for btnIndex in 0...9 {

            CDButtonArray[btnIndex].setImage(#imageLiteral(resourceName: "dark_color_record"), for: .normal)
            self.imageView.addSubview(CDButtonArray[btnIndex])
            CDButtonArray[btnIndex].isHidden = true
            CDButtonArray[btnIndex].tag = btnIndex

//            CDButtonArray[btnIndex].addTarget(self, action: #selector(showRecordInfo), for: .touchUpInside)

        }

        CDButtonSetup(index: 0, positionX: 4.4, positionY: 48)
        CDButtonSetup(index: 1, positionX: 16.1, positionY: 53)
        CDButtonSetup(index: 2, positionX: 28, positionY: 53)
        CDButtonSetup(index: 3, positionX: 39.25, positionY: 49)
        CDButtonSetup(index: 4, positionX: 51.75, positionY: 49)
        CDButtonSetup(index: 5, positionX: 65.75, positionY: 49)
        CDButtonSetup(index: 6, positionX: 80, positionY: 49)
        CDButtonSetup(index: 7, positionX: 93.75, positionY: 49)
        CDButtonSetup(index: 8, positionX: 87.5, positionY: 46.4)
        CDButtonSetup(index: 9, positionX: 12.5, positionY: 21.4)
        
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

    func levelCase(index: Int, positionX: CGFloat) {

        CDButtonArray[index].isHidden = false
        explosionArray[index].isHidden = false
        animate(imageView: explosionArray[index], images: explosionImages)
        UIView.animate(withDuration: 2.0, animations: {
            self.monster.frame = CGRect(x: positionX * self.imageView.bounds.width/100,
                                        y: 73 * self.imageView.bounds.height/100,
                                        width: self.monster.frame.size.width,
                                        height: self.monster.frame.size.height)
        })
        
    }

    @objc func showCDButton(notification: Notification) {

        self.checkLevel = LevelStatusManager.shared.level!

        explosionImages = createImageAnimation(total: 37, imageRefix: "Comp 1_000")

        switch checkLevel {
        case 1:
            CDButtonArray[0].isHidden = false
            explosionArray[0].isHidden = false
            animate(imageView: explosionArray[0], images: explosionImages)
//            self.imageView.bounds = CGRect(x: 2 * self.imageView.bounds.width/100, y: 0 * self.imageView.bounds.height/100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        case 2:
            levelCase(index: 1, positionX: 14)
        case 3:
            levelCase(index: 2, positionX: 25)
        case 4:
            levelCase(index: 3, positionX: 37)
        case 5:
            levelCase(index: 4, positionX: 48)
        case 6:
            levelCase(index: 5, positionX: 64)
        case 7:
            levelCase(index: 6, positionX: 78)
        case 8:
            levelCase(index: 7, positionX: 90)
        case 9:
            CDButtonArray[8].isHidden = false
            explosionArray[8].isHidden = false
            animate(imageView: explosionArray[8], images: explosionImages)
        default:
            CDButtonArray[9].isHidden = false
            explosionArray[9].isHidden = false
            animate(imageView: explosionArray[9], images: explosionImages)
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

    func createImageAnimationForGhost(total: Int, imageRefix: String) -> [UIImage] {

        var imageArray: [UIImage] = []

        for imageCount in 0..<total {
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
        //image: UIImage, hint: String --- NOTE: Add to function parameter when image and text is ready
        guard let popUpRecordView = UIStoryboard.gameStoryboard().instantiateViewController(withIdentifier: "popUpRecord") as? PopUpRecordViewController else { return }
        self.addChildViewController(popUpRecordView)
        popUpRecordView.view.frame = self.view.frame
        self.view.addSubview(popUpRecordView.view)
//        popUpRecordView.recordTitle.text = hint
//        popUpRecordView.recordCover = UIImageView(image: image)
        popUpRecordView.view.alpha = 0
        popUpRecordView.introView.isHidden = true
//        popUpRecordView.recordCover.image = #imageLiteral(resourceName: "headphone")
        UIView.animate(withDuration: 0.3) {
            popUpRecordView.view.alpha = 1
            popUpRecordView.didMove(toParentViewController: self)
        }
    }

}
