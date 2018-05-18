//
//  CollectionViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/6.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class CollectionViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var recordsContainerView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var secondCollectionText: UILabel!
    @IBOutlet weak var collectionCover: UIImageView!

    let topViewHeight: CGFloat = 255
    var changePoint: CGFloat = 0
    var alphaPoint: CGFloat = 190
    var recordTransition: CGFloat?
    var collectionTransition: CGFloat?

    let designSetting = DesignSetting()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.title = ""
        collectionCover.layer.cornerRadius = collectionCover.bounds.size.width * 0.5

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let collectionListViewController = segue.destination as? CollectionListViewController {
            collectionListViewController.delegate = self
        }
    }

}

extension CollectionViewController: CollectionListControllerDelegate {

    func collectionViewDidScroll(_ controller: CollectionListViewController, translation: CGFloat) {
        self.collectionTransition = translation
        changeTopView()
    }

    func changeTopView() {

        guard let collectionY = collectionTransition else { return }
        if collectionY <= changePoint {
            topView.frame = CGRect(x: 0, y: (0 - collectionY), width: topView.frame.width, height: topViewHeight)

        }
        if collectionY <= alphaPoint {
            let percentage = collectionY/alphaPoint
            print(percentage)
            collectionCover.alpha = 1.0 - percentage
        }
    }

}
