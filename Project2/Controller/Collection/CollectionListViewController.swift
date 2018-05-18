//
//  CollectionListViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/17.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import SDWebImage

protocol CollectionListControllerDelegate: class {
    func collectionViewDidScroll(_ controller: CollectionListViewController, translation: CGFloat)
}

class CollectionListViewController: UIViewController {

    @IBOutlet weak var recordCollectionView: UICollectionView!

    weak var delegate: CollectionListControllerDelegate?

    let designSetting = DesignSetting()

    let sortedArray = DBProvider.shared.sortedArray

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setCollectionLayout()

        designSetting.designSetting(view: recordCollectionView)

        recordCollectionView.contentInset = UIEdgeInsets(top: 190, left: 0, bottom: 0, right: 0)
        recordCollectionView.contentOffset = CGPoint(x: 0, y: -190)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        recordCollectionView.reloadData()
    }

    func setupCollectionView() {
        let nib = UINib(nibName: String(describing: RecordCollectionViewCell.self), bundle: nil)
        recordCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: RecordCollectionViewCell.self))
        recordCollectionView.delegate = self
        recordCollectionView.dataSource = self
    }

    func setCollectionLayout() {
        if let setLayout = recordCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemSize = UIScreen.main.bounds.width/2
            setLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            setLayout.itemSize = CGSize(width: itemSize, height: itemSize)
            setLayout.minimumLineSpacing = 0
            setLayout.minimumInteritemSpacing = 0
        }
    }

}

extension CollectionListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if LevelStatusManager.shared.level! - 1 <= 9 {
            return LevelStatusManager.shared.level!
        }

        return 10

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let recordCell = recordCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RecordCollectionViewCell.self), for: indexPath) as? RecordCollectionViewCell

//        setCollectionLayout()

        let sortedArray = DBProvider.shared.sortedArray
        let info = sortedArray![indexPath.row]
        recordCell?.artist.text = info.artist
        recordCell?.trackName.text = info.trackName
        recordCell?.cover.sd_setImage(with: URL(string: info.cover))

        return recordCell!
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let collectionListY = scrollView.contentOffset.y
        let movingDistance = collectionListY - (-190)
        self.delegate?.collectionViewDidScroll(self, translation: movingDistance)

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let playerVC = UIStoryboard.playerStoryboard().instantiateInitialViewController() as? PlayerViewController else {
            return
        }
        let info = sortedArray![indexPath.row]
        SpotifyManager.shared.playMusic(track: info.trackUri)
        self.navigationController?.pushViewController(playerVC, animated: true)

    }

}
