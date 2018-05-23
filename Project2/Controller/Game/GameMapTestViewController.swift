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
    let CDButtonArray = [UIButton(), UIButton(), UIButton(), UIButton()]

    override func viewDidLoad() {
        super.viewDidLoad()

        createScrollViewAndMap()
        createButton()
        loadButton()

        setExplosionImage()
        animate(imageView: explosionImage, images: explosionImages)

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
                CDButtonArray[level].isHidden = false
            }
        }

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

        for btnIndex in 0...3 {
            CDButtonArray[btnIndex].setImage(#imageLiteral(resourceName: "dark_color_record"), for: .normal)
            self.imageView.addSubview(CDButtonArray[btnIndex])
            CDButtonArray[btnIndex].isHidden = true
//            CDButtonArray[btnIndex].addTarget(self, action: #selector(showRecordInfo), for: .touchUpInside)
            CDButtonArray[btnIndex].tag = btnIndex
        }

        CDButtonArray[0].frame = CGRect(x: 10 * imageView.bounds.width/100,
                                        y: 40 * imageView.bounds.height/100, width: 80, height: 80)
        CDButtonArray[1].frame = CGRect(x: 38 * imageView.bounds.width/100,
                                        y: 45 * imageView.bounds.height/100, width: 80, height: 80)
        CDButtonArray[2].frame = CGRect(x: 75 * imageView.bounds.width/100,
                                        y: 40 * imageView.bounds.height/100, width: 80, height: 80)
        CDButtonArray[3].frame = CGRect(x: 95 * imageView.bounds.width/100,
                                        y: 30 * imageView.bounds.height/100, width: 80, height: 80)

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

        explosionImage = UIImageView()
        explosionImage.backgroundColor = UIColor.clear
        imageView.addSubview(explosionImage)
        explosionImage.frame = CGRect(x: 40, y: 40, width: 60, height: 60)
        explosionImages = createImageAnimation(total: 37, imageRefix: "Comp 1_000")

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

        switch checkLevel {
        case 1:
            CDButtonArray[0].isHidden = false
        case 2:
            CDButtonArray[1].isHidden = false
        case 3:
            CDButtonArray[2].isHidden = false
        default:
            CDButtonArray[3].isHidden = false
        }

    }

}
