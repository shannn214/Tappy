//
//  MurmurView.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/3.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class MurmurView: UIView {

    init() {

        super.init(frame: CGRect(x: 0, y: 0, width: 120, height: 30))

        isUserInteractionEnabled = false

        self.backgroundColor = UIColor.yellow
        self.layer.cornerRadius = 15

    }

    func createMurmur(completion: @escaping () -> Void) {

        UIView.animate(withDuration: 1.0, animations: {
            self.alpha = 1
        }) { (_) in
            UIView.animate(withDuration: 0.7, delay: 3, animations: {
                self.alpha = 0
            }) { (_) in
                completion()
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
