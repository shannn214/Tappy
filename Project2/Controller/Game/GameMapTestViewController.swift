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
    let explosionArray = [UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView(), UIImageView()]

    let animation = CAKeyframeAnimation(keyPath: "position")

    override func viewDidLoad() {
        super.viewDidLoad()

        createScrollViewAndMap()
        createButton()

        setExplosionImage()
        loadButton()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showCDButton(notification:)),
            name: .pressMovingButton,
            object: nil
        )
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//    }

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
//                animate(imageView: explosionArray[0], images: explosionImages)

                animate(imageView: explosionImage, images: explosionImages)

            }
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        explosionImages = createImageAnimation(total: 37, imageRefix: "Comp 1_000")
//
//        for level in 0...7 {
//            animate(imageView: explosionArray[0], images: explosionImages)
//
//        }

    }

    func movingAnimation() {

        let start = CGPoint(x: 3 * imageView.bounds.width/100,
                            y: 12 * imageView.bounds.height/100)
        let end = CGPoint(x: 14 * imageView.bounds.width/100,
                          y: 12 * imageView.bounds.height/100)

        animation.values = [NSValue(cgPoint: start), NSValue(cgPoint: end)]

        animation.keyTimes = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]

        animation.duration = 2.0

        imageView.layer.add(animation, forKey: "move")
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

    func createButton() {

        for btnIndex in 0...9 {
            CDButtonArray[btnIndex].setImage(#imageLiteral(resourceName: "dark_color_record"), for: .normal)
            self.imageView.addSubview(CDButtonArray[btnIndex])
            CDButtonArray[btnIndex].isHidden = true
//            CDButtonArray[btnIndex].addTarget(self, action: #selector(showRecordInfo), for: .touchUpInside)
            CDButtonArray[btnIndex].tag = btnIndex
        }

        CDButtonArray[0].frame = CGRect(x: 4.4 * imageView.bounds.width/100,
                                        y: 48 * imageView.bounds.height/100, width: 60, height: 60)
        CDButtonArray[1].frame = CGRect(x: 16 * imageView.bounds.width/100,
                                        y: 53 * imageView.bounds.height/100, width: 60, height: 60)
        CDButtonArray[2].frame = CGRect(x: 28 * imageView.bounds.width/100,
                                        y: 53 * imageView.bounds.height/100, width: 60, height: 60)
        CDButtonArray[3].frame = CGRect(x: 39.25 * imageView.bounds.width/100,
                                        y: 49 * imageView.bounds.height/100, width: 60, height: 60)
        CDButtonArray[4].frame = CGRect(x: 51.75 * imageView.bounds.width/100,
                                        y: 49 * imageView.bounds.height/100, width: 60, height: 60)
        CDButtonArray[5].frame = CGRect(x: 65.75 * imageView.bounds.width/100,
                                        y: 49 * imageView.bounds.height/100, width: 60, height: 60)
        CDButtonArray[6].frame = CGRect(x: 80 * imageView.bounds.width/100,
                                        y: 49 * imageView.bounds.height/100, width: 60, height: 60)
        CDButtonArray[7].frame = CGRect(x: 93.75 * imageView.bounds.width/100,
                                        y: 49 * imageView.bounds.height/100, width: 60, height: 60)
        CDButtonArray[8].frame = CGRect(x: 98 * imageView.bounds.width/100,
                                        y: 49 * imageView.bounds.height/100, width: 60, height: 60)
        CDButtonArray[9].frame = CGRect(x: 97 * imageView.bounds.width/100,
                                        y: 49 * imageView.bounds.height/100, width: 60, height: 60)

    }

    @objc func showRecordInfo(sender: UIButton!) {

//        var btnSendTag: UIButton = sender
//        switch btnSendTag.tag {
//        case 0:
//            SpotifyManager.shared.playMusic(track: DBProvider.shared.sortedArray![0].trackUri)
//        //use database to insert track value
//        default:
//            SpotifyManager.shared.playMusic(track: DBProvider.shared.sortedArray![1].trackUri)
//        }

    }

    func setExplosionImage() {

//        for explosionIndex in 0...7 {
////            explosionImages = createImageAnimation(total: 37, imageRefix: "Comp 1_000")
//
//            self.imageView.addSubview(explosionArray[explosionIndex])
//            explosionArray[explosionIndex].backgroundColor = UIColor.clear
//            explosionArray[explosionIndex].isHidden = true
//            explosionArray[explosionIndex].tag = explosionIndex
////            animate(imageView: explosionArray[explosionIndex], images: explosionImages)
//
//        }
//
//        explosionArray[0].frame = CGRect(x: 4.4 * imageView.bounds.width/100,
//                                         y: 48 * imageView.bounds.height/100, width: 90, height: 90)

        explosionImage = UIImageView()
        explosionImage.backgroundColor = UIColor.clear
        imageView.addSubview(explosionImage)
        explosionImage.frame = CGRect(x: 3.1 * imageView.bounds.width/100,
                                      y: 39 * imageView.bounds.height/100, width: 180, height: 180)
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

        explosionImage.animationImages = images
        explosionImage.animationDuration = 0.8
        explosionImage.animationRepeatCount = 0
        explosionImage.startAnimating()

    }

    @objc func showCDButton(notification: Notification) {

        self.checkLevel = LevelStatusManager.shared.level!

        explosionImages = createImageAnimation(total: 37, imageRefix: "Comp 1_000")

        switch checkLevel {
        case 1:
            CDButtonArray[0].isHidden = false
            explosionArray[0].isHidden = false
//            animate(imageView: explosionArray[0], images: explosionImages)
            animate(imageView: explosionImage, images: explosionImages)
        case 2:
            CDButtonArray[1].isHidden = false
        case 3:
            CDButtonArray[2].isHidden = false
        case 4:
            CDButtonArray[3].isHidden = false
        case 5:
            CDButtonArray[4].isHidden = false
        case 6:
            CDButtonArray[5].isHidden = false
        case 7:
            CDButtonArray[6].isHidden = false
        case 8:
            CDButtonArray[7].isHidden = false
        case 9:
            CDButtonArray[8].isHidden = false
        default:
            CDButtonArray[9].isHidden = false
        }

    }

}
