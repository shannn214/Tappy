//
//  PopUpRecordViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/8.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit
import SDWebImage

class PopUpRecordViewController: UIViewController {

    @IBOutlet weak var recordCover: UIImageView!
    @IBOutlet weak var recordTitle: UILabel!
    @IBOutlet weak var propView: UIView!
    @IBOutlet weak var introView: UIView!
    
    weak var delegate = UIApplication.shared.delegate as? AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        recordCover.alpha = 0

        let tap = UITapGestureRecognizer(target: self, action: #selector(touchCover))
        recordCover.isUserInteractionEnabled = true
        recordCover.addGestureRecognizer(tap)

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)

        self.propView.layer.cornerRadius = 20
        self.introView.layer.cornerRadius = 20
        
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(showInfo(notification:)),
//            name: .startPlayingTrack,
//            object: nil
//        )

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    @objc func touchCover() {

        let playerVC = UIStoryboard.playerStoryboard().instantiateInitialViewController()
        self.present(playerVC!, animated: true, completion: nil)

    }

    @IBAction func nextButton(_ sender: Any) {
        self.view.removeFromSuperview()
    }
    
    
    @IBAction func leaveButton(_ sender: Any) {

        NotificationCenter.default.post(name: .leavePropPopView,
                                        object: nil
                                        )
        self.view.removeFromSuperview()

    }

    func showAnimation() {
//        TO DO
    }

    func removeAnimation() {
//        TO DO
    }

//    Animation
    func rotate(image: UIImageView) {

        let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: .pi * 2.0)
        rotationAnimation.duration = 10
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = .infinity
        image.layer.add(rotationAnimation, forKey: "rotationAnimation")
        image.layer.cornerRadius = image.bounds.size.width * 0.5

    }

}
