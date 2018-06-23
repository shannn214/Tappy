//
//  Functions.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/7.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

extension UIViewController {

    func setupGradient(layer: CAGradientLayer) -> CAGradientLayer {

        layer.colors = [
            AppColor.gradientFirst,
            AppColor.gradientSecond
        ]

        layer.locations = [0.0, 0.35]

        layer.startPoint = CGPoint(x: 0.5, y: 0.0)

        layer.endPoint = CGPoint(x: 0.5, y: 1.0)

        layer.frame = UIScreen.main.bounds

        return layer

    }

    func addPopUpRecordVC(popUpRecordVC: PopUpRecordViewController) {

        self.addChildViewController(popUpRecordVC)
        popUpRecordVC.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.view.addSubview(popUpRecordVC.view)
        popUpRecordVC.didMove(toParentViewController: self)

    }

    func popUpViewAnimation(popUpRecordVC: PopUpRecordViewController) {

        UIView.animate(withDuration: 0.2) {
            popUpRecordVC.view.alpha = 1
            popUpRecordVC.didMove(toParentViewController: self)
        }

    }

}
