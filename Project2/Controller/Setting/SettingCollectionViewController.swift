//
//  SettingCollectionViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/27.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

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

    }

    func setupCollectionLayout() {

        settingCollectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)

        if let setLayout = settingCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {

            let itemSize = UIScreen.main.bounds.width

            setLayout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)

            setLayout.itemSize = CGSize(width: itemSize * 0.9, height: itemSize * 1.2)

            setLayout.minimumLineSpacing = 50

            setLayout.minimumInteritemSpacing = 0

        }

    }

}

extension SettingCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return controllers.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = settingCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SettingCollectionViewCell.self), for: indexPath) as? SettingCollectionViewCell else { return UICollectionViewCell() }

        guard let settingDetailVC = controllers[indexPath.row] as? SettingDetailViewController else { return cell }

        cell.delegate = self

        self.addChildViewController(settingDetailVC)

        cell.cellView.addSubview(settingDetailVC.view)

        settingDetailVC.view.frame = cell.contentView.bounds

        settingDetailVC.didMove(toParentViewController: self)

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
                        self.settingCollectionView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95) },
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

extension SettingCollectionViewController: CellViewDelegate {

    func cellTouchedEnded(_ cell: SettingCollectionViewCell) {

        selectedIndex = settingCollectionView.indexPath(for: cell)

        guard let settingDetailVC = controllers[(selectedIndex?.row)!] as? SettingDetailViewController else { return }

        settingDetailVC.view.removeFromSuperview()

        self.view.addSubview(settingDetailVC.view)

        let point = settingCollectionView.convert(cell.frame.origin, to: self.view)

        self.selectedPoint = point

        settingDetailVC.view.frame = CGRect(origin: point, size: cell.contentView.bounds.size)

        UIView.animate(withDuration: 0.35) {
            settingDetailVC.view.frame = self.view.frame
            settingDetailVC.changeToFullScreen()
        }

    }

}
