//
//  MurmurView.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/3.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class MurmurView: UIView {

    let murmurLabel = UILabel()
    let murmurTextArray = ["Booo", "YaHaHa", "あぇ", ">_<", "Blalaala", "uuuu", "だいすき"]

    let randomTextIndex = Int(arc4random_uniform(7))

    init() {

        super.init(frame: CGRect(x: 0, y: 0, width: 120, height: 30))

        isUserInteractionEnabled = false

        self.backgroundColor = UIColor(displayP3Red: 219/255, green: 165/255, blue: 63/255, alpha: 1)
        self.layer.cornerRadius = 15

        murmurLabel.text = murmurTextArray[randomTextIndex]
        murmurLabel.frame = CGRect(x: 10, y: 0, width: self.frame.width, height: self.frame.height)
        murmurLabel.font = UIFont(name: "CircularStd-Medium", size: 14)
        self.addSubview(murmurLabel)

    }

    func createMurmur(completion: @escaping () -> Void) {

        UIView.animate(withDuration: 1.0, animations: {
            self.alpha = 1
        }) { [weak self] (_) in
            UIView.animate(withDuration: 0.7, delay: 3, animations: {
                self?.alpha = 0
            }) { (_) in
                completion()
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
