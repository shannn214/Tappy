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

    override func viewDidLoad() {

        super.viewDidLoad()

        setupCollectionView()

        setupCollectionLayout()

    }

    func setupCollectionView() {

        let nib = UINib(nibName: String(describing: AchievementCollectionViewCell.self), bundle: nil)
        listCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: AchievementCollectionViewCell.self))
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.contentInset = UIEdgeInsets(top: 190, left: 0, bottom: 0, right: 0)
        listCollectionView.contentOffset = CGPoint(x: 0, y: -190)

    }

    func setupCollectionLayout() {

        if let setLayout = listCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemSize = UIScreen.main.bounds.width/2 - 5
            setLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            setLayout.itemSize = CGSize(width: itemSize, height: itemSize)
            setLayout.minimumLineSpacing = 5
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
            withReuseIdentifier: String(describing: AchievementCollectionViewCell.self),
            for: indexPath) as? AchievementCollectionViewCell

        return cardCell!
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let cardListY = scrollView.contentOffset.y
        let movingDistance = cardListY - (-255)
        self.delegate?.cardViewDisScroll(self, translation: movingDistance)

    }

}
