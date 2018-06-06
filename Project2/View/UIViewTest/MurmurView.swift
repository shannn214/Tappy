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
    
    override init(frame: CGRect) {

        super.init(frame: frame)

        isUserInteractionEnabled = false

        self.backgroundColor = UIColor(displayP3Red: 219/255, green: 165/255, blue: 63/255, alpha: 1)
        self.layer.cornerRadius = 15

        self.addMurmur()
    }

    func addMurmur() {

//        let labelSize: CGSize =

        let uuuuu = murmurTextArray[randomTextIndex]
        let width = uuuuu.widthOfString(usingFont: UIFont(name: "CircularStd-Medium", size: 14)!)
        murmurLabel.text = uuuuu
        murmurLabel.frame = CGRect(x: 10, y: 0, width: width + 4, height: self.frame.height)
        self.addSubview(murmurLabel)
        self.frame = CGRect(x: 0, y: 0, width: width + 20, height: self.frame.height)

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

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
}
