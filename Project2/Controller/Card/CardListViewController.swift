//
//  AchievementListViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/19.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

protocol CardListControllerDelegate: class {
    func cardViewDisScroll(_ controller: CardListViewController, translation: CGFloat)
}

class CardListViewController: UIViewController {

    @IBOutlet weak var listCollectionView: UICollectionView!

    weak var delegate: CardListControllerDelegate?

    let transitionAnimation = TransitionAnimation()

    var selectedCell: CardCollectionViewCell?

    override func viewDidLoad() {

        super.viewDidLoad()

        setupCollectionView()

        setupCollectionLayout()

    }

    func setupCollectionView() {

        let nib = UINib(nibName: String(describing: CardCollectionViewCell.self), bundle: nil)
        listCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: CardCollectionViewCell.self))
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.contentInset = UIEdgeInsets(top: 190, left: 0, bottom: 0, right: 0)
        listCollectionView.contentOffset = CGPoint(x: 0, y: -190)

    }

    func setupCollectionLayout() {

        if let setLayout = listCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemSize = UIScreen.main.bounds.width/2
            setLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            setLayout.itemSize = CGSize(width: itemSize, height: itemSize)
            setLayout.minimumLineSpacing = 0
            setLayout.minimumInteritemSpacing = 0
        }
    }

}

extension CardListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if LevelStatusManager.shared.level! - 1 <= 9 {
            return LevelStatusManager.shared.level!
        }

        return 10

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cardCell = listCollectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: CardCollectionViewCell.self),
            for: indexPath) as? CardCollectionViewCell
        let storyboard = UIStoryboard(name: "CardDetail", bundle: nil)
        let cardDetailVC = storyboard.instantiateViewController(withIdentifier: String(describing: CardDetailViewController.self)) as? CardDetailViewController

        self.addChildViewController(cardDetailVC!)
        cardCell?.cardCellView.addSubview((cardDetailVC?.view)!)
        cardDetailVC?.view.frame = (cardCell?.contentView.bounds)!
        cardDetailVC?.didMove(toParentViewController: self)

        cardCell?.clipsToBounds = true

//        cardDetailVC?.view.frame = CGRect(x: 0, y: -100, width: UIScreen.main.bounds.width/2, height: 120)
//        cardDetailVC?.view.clipsToBounds = true

        return cardCell!
    }

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
    //------------------------------------------

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let cardListY = scrollView.contentOffset.y
        let movingDistance = cardListY - (-255)
        self.delegate?.cardViewDisScroll(self, translation: movingDistance)

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        selectedCell = listCollectionView.cellForItem(at: indexPath) as? CardCollectionViewCell

//        self.addChildViewController(cardDetailVC!)

//        selectedCell?.clipsToBounds = false
//        selectedCell?.cardCellView.clipsToBounds = false

        selectedCell?.cardCellView.removeFromSuperview()

        let cardVC = UIStoryboard.cardStoryboard().instantiateInitialViewController() as? CardViewController
        cardVC?.view.addSubview((selectedCell?.cardCellView)!)

        selectedCell?.cardCellView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

    }

}

//extension CardListViewController: UIViewControllerTransitioningDelegate {
//
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//
//        guard let originFrame = selectedCell?.superview?.convert((selectedCell?.frame)!, to: nil) else { return transitionAnimation }
//
//        transitionAnimation.originFrame = originFrame
//
//        transitionAnimation.presenting = true
//
//        //        selectedCell?.isHidden = true
//
//        return transitionAnimation
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//
//        transitionAnimation.presenting = false
//
//        return transitionAnimation
//    }
//
//}
