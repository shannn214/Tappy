//
//  AchievementListViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/19.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class AchievementListViewController: UIViewController {

    @IBOutlet weak var listCollectionView: UICollectionView!

    override func viewDidLoad() {

        super.viewDidLoad()

        setupCollectionView()

        setCollectionLayout()

    }

    func setupCollectionView() {

        let nib = UINib(nibName: String(describing: AchievementCollectionViewCell.self), bundle: nil)
        listCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: AchievementCollectionViewCell.self))
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
    }

    func setCollectionLayout() {
        if let setLayout = listCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemSize = UIScreen.main.bounds.width/2
            setLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            setLayout.itemSize = CGSize(width: itemSize, height: itemSize)
            setLayout.minimumLineSpacing = 0
            setLayout.minimumInteritemSpacing = 0
        }
    }

}

extension AchievementListViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if LevelStatusManager.shared.level! - 1 <= 9 {
            return LevelStatusManager.shared.level!
        }

        return 10

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

}
