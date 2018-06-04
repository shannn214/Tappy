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

        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 30))

        isUserInteractionEnabled = false
        
        self.backgroundColor = UIColor.yellow
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.07, execute: {
//            self.createMurmur()
        })

    }

    func createMurmur() {

//        let dialog = UIView()
//        dialog.frame.size = CGSize(width: 50, height: 30)
//        dialog.center = self.center
//        dialog.layer.cornerRadius = 15
//        dialog.backgroundColor = UIColor(displayP3Red: 50/255, green: 50/255, blue: 50/255, alpha: 1)
//        dialog.alpha = 1
//
//        self.addSubview(dialog)

//        UIView.animate(withDuration: 1, animations: {
//            dialog.alpha = 1
//        }) { (_) in
//            UIView.animate(withDuration: 1, animations: {
//                dialog.alpha = 0
//            })
//        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
