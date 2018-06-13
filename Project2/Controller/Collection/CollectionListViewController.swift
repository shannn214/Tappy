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

    func playerViewDidDismiss(url: String)

}

class CollectionListViewController: UIViewController {

    @IBOutlet weak var recordCollectionView: UICollectionView!

    weak var delegate: CollectionListControllerDelegate?

    let designSetting = DesignSetting()

//    let ahhsortedArray = DBProvider.shared.sortedArray

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()

        setCollectionLayout()
//        setupTrackCell()

        designSetting.designSetting(view: recordCollectionView)

    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        recordCollectionView.reloadData()

    }

    private func setupCollectionView() {

        let nib = UINib(nibName: String(describing: RecordCollectionViewCell.self), bundle: nil)
        recordCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: RecordCollectionViewCell.self))
        recordCollectionView.delegate = self
        recordCollectionView.dataSource = self
        recordCollectionView.contentInset = UIEdgeInsets(top: 190, left: 0, bottom: 0, right: 0)
        recordCollectionView.contentOffset = CGPoint(x: 0, y: -190)
        // NOTE: contentOffset didn't change anything?

    }

    private func setupTrackCell() {

        let nib = UINib(nibName: String(describing: TrackCollectionViewCell.self), bundle: nil)
        recordCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: TrackCollectionViewCell.self))

    }

    private func setCollectionLayout() {

        if let setLayout = recordCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemSize = UIScreen.main.bounds.width / 2
            setLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            setLayout.itemSize = CGSize(width: itemSize, height: 210)
            setLayout.minimumLineSpacing = 1
            setLayout.minimumInteritemSpacing = 0
        }

    }

}

extension CollectionListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 10

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let recordCell = recordCollectionView.dequeueReusableCell(
                                    withReuseIdentifier: String(describing: RecordCollectionViewCell.self),
                                    for: indexPath) as? RecordCollectionViewCell
        else { return UICollectionViewCell() }

        setCollectionLayout()

        let sortedArray = DBProvider.shared.sortedArray
        let info = sortedArray![indexPath.row]
        recordCell.artist.text = info.artist
        recordCell.trackName.text = info.trackName
        recordCell.cover.sd_setImage(with: URL(string: info.cover))
        recordCell.cover.isHidden = true
        recordCell.artist.isHidden = true
        recordCell.trackName.isHidden = true
        recordCell.isUserInteractionEnabled = false

        if indexPath.row < LevelStatusManager.shared.level! {

            recordCell.cover.isHidden = false
            recordCell.artist.isHidden = false
            recordCell.trackName.isHidden = false
            recordCell.isUserInteractionEnabled = true

        }

        return recordCell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let collectionListY = scrollView.contentOffset.y
        let movingDistance = collectionListY - (-255)
        self.delegate?.collectionViewDidScroll(self, translation: movingDistance)

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let playerVC = UIStoryboard.playerStoryboard().instantiateInitialViewController() as? PlayerViewController else { return }
        let sortedArray = DBProvider.shared.sortedArray
        if let info = sortedArray?[indexPath.row] {

            SpotifyManager.shared.playMusic(track: info.trackUri)

            present(playerVC, animated: true) {

                playerVC.playerPanelView.cover.sd_setImage(with: URL(string: info.cover))
                playerVC.backgroundCover.sd_setImage(with: URL(string: info.cover))
                playerVC.playerPanelView.artist.text = info.artist
                playerVC.playerPanelView.trackName.text = info.trackName
                self.delegate?.playerViewDidDismiss(url: info.cover)

            }

        } else {

            present(playerVC, animated: true) {

                playerVC.playerPanelView.artist.text = "eee"
                playerVC.playerPanelView.trackName.text = "eee"

            }

        }

    }

}
