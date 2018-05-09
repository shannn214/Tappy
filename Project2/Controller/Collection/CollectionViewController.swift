//
//  CollectionViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/6.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class CollectionViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var recordContainerView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var firstCollectionText: UILabel!
    @IBOutlet weak var secondCollectionText: UILabel!

    let topViewHeight: CGFloat = 190
    var changePoint: CGFloat = 0
    var showPoint: CGFloat = 65
    var recordTransition: CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()

        firstCollectionText.isHidden = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recordViewController = segue.destination as? RecordListViewController {
            recordViewController.delegate = self
        }
    }

}

extension CollectionViewController: RecordListControllerDelegate {

    func recordViewDidScroll(_ controller: RecordListViewController, translation: CGFloat) {
        self.recordTransition = translation
        changeTopView()
    }

    func changeTopView() {
        guard let recordY = recordTransition else { return }
        if recordY <= changePoint {
            topView.frame = CGRect(x: 0, y: (60 - recordY), width: topView.frame.width, height: topViewHeight)
        }
        if recordY >= showPoint {
            firstCollectionText.isHidden = false
        } else {
            firstCollectionText.isHidden = true
        }

    }

}
