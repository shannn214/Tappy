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

    var cellIndex: IndexPath?

    var selectedIndex: IndexPath?

    var selectedPoint: CGPoint?

    var seletedCell: UICollectionViewCell?

    var detailVC: SettingDetailViewController!

    let sortedArray = DBProvider.shared.sortedArray

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()

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

        detailVC.view.translatesAutoresizingMaskIntoConstraints = false

        let yPoint = detailVC.view.topAnchor.constraint(equalTo: view.topAnchor, constant: point.y)

        yPoint.isActive = true

        let xPoint = detailVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: point.x)

        xPoint.isActive = true

        let width = detailVC.view.widthAnchor.constraint(equalToConstant: itemSize * 0.85)

        width.isActive = true

        let height = detailVC.view.heightAnchor.constraint(equalToConstant: itemSize * 0.9)

        height.isActive = true

        self.selectedPoint = point

        self.view.layoutIfNeeded()

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {

            xPoint.constant = 0

            yPoint.constant = 0

            width.constant = self.view.frame.width

            height.constant = self.view.frame.height

            self.view.layoutIfNeeded()

            self.detailVC.changeToFullScreen()

        }, completion: nil)

        cell.cellView.isHidden = true

    }

}

extension SettingCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemSize = UIScreen.main.bounds.width

        return CGSize(width: itemSize * 0.85, height: itemSize * 0.9)
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
