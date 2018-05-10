//
//  DesignSetting.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/10.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

struct DesignSetting {

    func designSetting(view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 10
    }

}
