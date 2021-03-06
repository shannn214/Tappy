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

    let randomTextIndex = Int(arc4random_uniform(7))

    let uriManager = SpotifyUrisManager.createManagerFromFile()

    override init(frame: CGRect) {

        super.init(frame: frame)

        addMurmur()
    }

    func addMurmur() {

        isUserInteractionEnabled = false

        self.backgroundColor = UIColor(displayP3Red: 219/255, green: 165/255, blue: 63/255, alpha: 1)
        self.layer.cornerRadius = 15

        guard let levelStatus = LevelStatusManager.shared.level else { return }

        var murmurArray = uriManager.uris[levelStatus - 1].murmur

        let dialog = murmurArray[randomTextIndex]

        let width = dialog.widthOfString(usingFont: UIFont(name: SHConstants.font, size: 14)!)

        murmurLabel.text = dialog
        murmurLabel.font = UIFont(name: SHConstants.font, size: 14)
        murmurLabel.numberOfLines = 0
        murmurLabel.adjustsFontSizeToFitWidth = true
        murmurLabel.frame = CGRect(x: 10, y: 0, width: width + 4, height: self.frame.height)
        self.addSubview(murmurLabel)
        self.frame = CGRect(x: 0, y: 0, width: width + 20, height: self.frame.height)

    }

    func createMurmur(completion: @escaping () -> Void) {

        UIView.animate(withDuration: 1.0,
                       animations: {
                            self.alpha = 1 },
                       completion: { [weak self] (_) in

                            UIView.animate(withDuration: 0.7,
                                           delay: 3,
                                           animations: {
                                                self?.alpha = 0 },
                                           completion: { (_) in
                                                completion()
                            })

        })

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        addMurmur()
    }
}

extension String {
    // NOTE: String length
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

}
