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

    var seletedCell: UICollectionViewCell?

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

    }

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

        guard let cell = appStoreCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AppStoreCollectionViewCell.self), for: indexPath) as? AppStoreCollectionViewCell else { return UICollectionViewCell() }

        guard let appStoreDetailVC = controllers[indexPath.row] as? AppStoreDetailViewController else { return cell }

        cell.delegate = self

        self.addChildViewController(appStoreDetailVC)

        cell.appStoreCellView.addSubview(appStoreDetailVC.view)

        appStoreDetailVC.view.frame = cell.contentView.bounds

        appStoreDetailVC.didMove(toParentViewController: self)

        cell.clipsToBounds = true

        cellIndex = indexPath

        return cell
    }

    @objc func tapCell(sender: UITapGestureRecognizer) {

    }

    func touchCellContentView() {

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.1,
                       options: .curveEaseInOut,
                       animations: {
                        self.appStoreCollectionView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95) },
                       completion: nil)

    }

    func touchCellContentEnded() {

        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.view.transform = CGAffineTransform.identity
        }, completion: nil)

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

}

extension AppStoreViewController: CellViewDelegate {

    func cellTouchedEnded(_ cell: AppStoreCollectionViewCell) {

        selectedIndex = appStoreCollectionView.indexPath(for: cell)

        guard let appStoreDetailVC = controllers[(selectedIndex?.row)!] as? AppStoreDetailViewController else { return }

        appStoreDetailVC.view.removeFromSuperview()

        self.view.addSubview(appStoreDetailVC.view)

        let point = appStoreCollectionView.convert(cell.frame.origin, to: self.view)

        self.selectedPoint = point

        appStoreDetailVC.view.frame = CGRect(origin: point, size: cell.contentView.bounds.size)

        UIView.animate(withDuration: 0.35) {
            appStoreDetailVC.view.frame = self.view.frame
            appStoreDetailVC.changeToFullScreen()
        }

    }

}
