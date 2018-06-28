//
//  SettingCollectionViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/27.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit
import SDWebImage

class SettingCollectionViewController: UIViewController {

    @IBOutlet weak var settingCollectionView: UICollectionView!

    lazy var controllers: [UIViewController] = [
        UIStoryboard(name: "Setting", bundle: nil).instantiateViewController(withIdentifier: String(describing: SettingDetailViewController.self)),
        UIStoryboard(name: "Setting", bundle: nil).instantiateViewController(withIdentifier: String(describing: SettingDetailViewController.self))
    ]

    var cellIndex: IndexPath?

    var selectedIndex: IndexPath?

    var selectedPoint: CGPoint?

    var seletedCell: UICollectionViewCell?

    var detailVC: SettingDetailViewController!

    let sortedArray = DBProvider.shared.sortedArray

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()

        setupCollectionLayout()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    func setupCollectionView() {

        let nib = UINib(nibName: String(describing: SettingCollectionViewCell.self), bundle: nil)
        settingCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: SettingCollectionViewCell.self))
        settingCollectionView.delegate = self
        settingCollectionView.dataSource = self
        settingCollectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)

        detailVC = UIStoryboard.settingStoryboard().instantiateViewController(withIdentifier: String(describing: SettingDetailViewController.self)) as? SettingDetailViewController
    }

    func setupCollectionLayout() {

    }

}

extension SettingCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 4

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = settingCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SettingCollectionViewCell.self), for: indexPath) as? SettingCollectionViewCell else { return UICollectionViewCell() }

        cell.delegate = self

        cellIndex = indexPath

        guard let info = sortedArray?[indexPath.row] else { return UICollectionViewCell() }

        cell.cellImage.sd_setImage(with: URL(string: info.cover))

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print("cell did select")

        detailVC.selectedIndex = indexPath

        print("cell index did sent")

    }

}

extension SettingCollectionViewController: CellViewDelegate {

    func cellTouchedEnded(_ cell: SettingCollectionViewCell) {

        print("delegate: cell touch")

        self.view.addSubview(detailVC.view)

        let point = settingCollectionView.convert(cell.frame.origin, to: self.view)

        let itemSize = UIScreen.main.bounds.width

        self.selectedPoint = point

        detailVC.view.frame = CGRect(origin: CGPoint(x: 0, y: point.y), size: CGSize(width: itemSize, height: itemSize * 0.9))

        cell.cellView.isHidden = true

        UIView.animate(withDuration: 0.35) {
            self.detailVC.view.frame = self.view.frame
            self.detailVC.changeToFullScreen()
        }

    }

}

extension SettingCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemSize = UIScreen.main.bounds.width

        return CGSize(width: itemSize, height: itemSize * 0.9)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 50
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
    }

}
