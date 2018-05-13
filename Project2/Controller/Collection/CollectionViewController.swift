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
    @IBOutlet weak var secondCollectionText: UILabel!
    @IBOutlet weak var collectionCover: UIImageView!

    let topViewHeight: CGFloat = 255
    var changePoint: CGFloat = 0
    var showPoint: CGFloat = 70
    var recordTransition: CGFloat?

    let designSetting = DesignSetting()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.title = ""
        designSetting.designSetting(view: collectionCover)

        SpotifyManager.shared.getTrackInfo()
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
            topView.frame = CGRect(x: 0, y: (0 - recordY), width: topView.frame.width, height: topViewHeight)
        }
        if recordY <= showPoint {
            self.navigationController?.navigationBar.topItem?.title = ""
        } else {
            self.navigationController?.navigationBar.topItem?.title = "Collection"
        }

    }

}
