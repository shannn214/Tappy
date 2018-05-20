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
//        setupTrackCell()

        designSetting.designSetting(view: recordCollectionView)

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
        recordCollectionView.contentInset = UIEdgeInsets(top: 190, left: 0, bottom: 0, right: 0)
        recordCollectionView.contentOffset = CGPoint(x: 0, y: -190)

    }

    func setupTrackCell() {

        let nib = UINib(nibName: String(describing: TrackCollectionViewCell.self), bundle: nil)
        recordCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: TrackCollectionViewCell.self))

    }

    func setCollectionLayout() {

        if let setLayout = recordCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemSize = UIScreen.main.bounds.width/2
            setLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            setLayout.itemSize = CGSize(width: itemSize, height: itemSize)
            setLayout.minimumLineSpacing = 1
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

        let recordCell = recordCollectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: RecordCollectionViewCell.self),
            for: indexPath) as? RecordCollectionViewCell

        setCollectionLayout()

        let sortedArray = DBProvider.shared.sortedArray
        let info = sortedArray![indexPath.row]
        recordCell?.artist.text = info.artist
        recordCell?.trackName.text = info.trackName
        recordCell?.cover.sd_setImage(with: URL(string: info.cover))

        //-------------put controller in cell-------
//        let trackCell = recordCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TrackCollectionViewCell.self), for: indexPath) as? TrackCollectionViewCell
//        let playerVC = UIStoryboard.playerStoryboard().instantiateInitialViewController() as? PlayerViewController
//        self.addChildViewController(playerVC!)
//        playerVC!.transitioningDelegate = self
//        playerVC!.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
//        playerVC!.view.clipsToBounds = true
//
//        trackCell?.trackCellView.addSubview((playerVC?.view)!)
//        trackCell?.clipsToBounds = true
//
//        playerVC?.artist.text = info.artist
//        playerVC?.trackName.text = info.trackName
//        playerVC?.cover.sd_setImage(with: URL(string: info.cover))

//        return trackCell!

        return recordCell!
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let collectionListY = scrollView.contentOffset.y
        let movingDistance = collectionListY - (-255)
        self.delegate?.collectionViewDidScroll(self, translation: movingDistance)

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let playerVC = UIStoryboard.playerStoryboard().instantiateInitialViewController() as? PlayerViewController else { return }
        let info = sortedArray![indexPath.row]
        SpotifyManager.shared.playMusic(track: info.trackUri)

//        present(playerVC, animated: true, completion: nil)

        present(playerVC, animated: true) {
            playerVC.playerPanelView.cover.sd_setImage(with: URL(string: info.cover))
            playerVC.backgroundCover.sd_setImage(with: URL(string: info.cover))
            playerVC.playerPanelView.artist.text = info.artist
            playerVC.playerPanelView.trackName.text = info.trackName
        }

    }

}

extension CollectionListViewController: UIViewControllerTransitioningDelegate {

//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return 
//    }

}
