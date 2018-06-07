//
//  AppStoreViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/6.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class AppStoreViewController: UIViewController {

    @IBOutlet weak var appStoreCollectionView: UICollectionView!

    lazy var controllers: [UIViewController] = [
        UIStoryboard(name: "AppStoreDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: AppStoreDetailViewController.self)),
        UIStoryboard(name: "AppStoreDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: AppStoreDetailViewController.self)),
        UIStoryboard(name: "AppStoreDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: AppStoreDetailViewController.self)),
        UIStoryboard(name: "AppStoreDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: AppStoreDetailViewController.self))
    ]

    var cellIndex: IndexPath?

    var selectedIndex: IndexPath?

    var selectedPoint: CGPoint?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()

        setupCollectionLayout()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupCollectionView() {

        let nib = UINib(nibName: String(describing: AppStoreCollectionViewCell.self), bundle: nil)
        appStoreCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: AppStoreCollectionViewCell.self))
        appStoreCollectionView.delegate = self
        appStoreCollectionView.dataSource = self

//        appStoreCollectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCellBeforeLose(sender:))))
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(appStoreCollectionView.endEditing(_:)))
//
//        cell.addGestureRecognizer(tapGestureRecognizer)

    }

//    @objc func tapCellBeforeLose(sender: UITapGestureRecognizer) {
//
//        if sender.state == .recognized {
//
//            guard let appStoreDetailVC = controllers[(selectedIndex?.row)!] as? AppStoreDetailViewController else { return }
//            appStoreDetailVC.view.frame.size = CGSize(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.width)
//        }
//
//    }

    func setupCollectionLayout() {

        appStoreCollectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)

        if let setLayout = appStoreCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {

            let itemSize = UIScreen.main.bounds.width

            setLayout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)

            setLayout.itemSize = CGSize(width: itemSize * 0.9, height: itemSize * 1.2)

            setLayout.minimumLineSpacing = 50

            setLayout.minimumInteritemSpacing = 0

        }

    }

}

extension AppStoreViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controllers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = appStoreCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AppStoreCollectionViewCell.self), for: indexPath) as? AppStoreCollectionViewCell

        guard let appStoreDetailVC = controllers[indexPath.row] as? AppStoreDetailViewController else { return cell! }

        self.addChildViewController(appStoreDetailVC)

        cell?.appStoreCellView.addSubview(appStoreDetailVC.view)

        appStoreDetailVC.view.frame = (cell?.contentView.bounds)!

        appStoreDetailVC.didMove(toParentViewController: self)

        cell?.clipsToBounds = true

        cellIndex = indexPath

        //----gesture test------
//        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(tapCellBeforeLose(sender:)))
//        longPressGesture.minimumPressDuration = 0.1
//        cell?.addGestureRecognizer(longPressGesture)
        //----------

        return cell!
    }
    //------
//    @objc func tapCellBeforeLose(sender: UILongPressGestureRecognizer) {
//
//        if sender.state == .began {
//
//            handleLongPressBegan()
//
//        } else if sender.state == .cancelled || sender.state == .ended {
//
//            handleLongPressEnded()
//
//        }
//
//    }
//
//    func handleLongPressBegan() {
//
//        UIView.animate(withDuration: 0.5,
//                       delay: 0,
//                       usingSpringWithDamping: 0.9,
//                       initialSpringVelocity: 0.1,
//                       options: .beginFromCurrentState,
//                       animations: {
////                        self.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
//                        guard let appStoreDetailVC = self.controllers[(self.selectedIndex?.row)!] as? AppStoreDetailViewController else { return }
//
//                        appStoreDetailVC.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
//
//        }, completion: nil)
//
//    }
//
//    func handleLongPressEnded() {
//
//        UIView.animate(withDuration: 0.3,
//                       delay: 0,
//                       options: .beginFromCurrentState,
//                       animations: {
//                        self.view.transform = CGAffineTransform.identity
//        }, completion: nil)
//
//    }

    //------

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let cell = appStoreCollectionView.cellForItem(at: indexPath) else { return }

        guard let appStoreDetailVC = controllers[indexPath.row] as? AppStoreDetailViewController else { return }

        appStoreDetailVC.view.removeFromSuperview()

        self.view.addSubview(appStoreDetailVC.view)

        let point = appStoreCollectionView.convert(cell.frame.origin, to: self.view)

        self.selectedIndex = indexPath
        self.selectedPoint = point

        appStoreDetailVC.view.frame = CGRect(origin: point, size: cell.contentView.bounds.size)

//        appStoreDetailVC.view.center = cell.contentView.center

        self.view.bringSubview(toFront: appStoreDetailVC.view)

        UIView.animate(withDuration: 1) {
            appStoreDetailVC.view.frame = self.view.frame
            appStoreDetailVC.changeToFullScreen()
        }

    }

}
