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

    lazy var controllers: [UIViewController] = [
        UIStoryboard(name: "CardDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: CardDetailViewController.self)),
        UIStoryboard(name: "CardDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: CardDetailViewController.self)),
        UIStoryboard(name: "CardDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: CardDetailViewController.self)),
        UIStoryboard(name: "CardDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: CardDetailViewController.self)),
        UIStoryboard(name: "CardDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: CardDetailViewController.self)),
        UIStoryboard(name: "CardDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: CardDetailViewController.self)),
        UIStoryboard(name: "CardDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: CardDetailViewController.self))
    ]

    let transitionAnimation = TransitionAnimation()

    var cardDetailVC: CardDetailViewController?

//    var selectedCell: CardCollectionViewCell?

    var selectedIndex: IndexPath?

    var selectedPoint: CGPoint?

    var cell: UICollectionViewCell?

    override func viewDidLoad() {

        super.viewDidLoad()

        setupCollectionView()

        setupCollectionLayout()

    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        listCollectionView.reloadData()

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

        return controllers.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cardCell = listCollectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: CardCollectionViewCell.self),
            for: indexPath) as? CardCollectionViewCell

        guard let cardDetailVC = controllers[indexPath.row] as? CardDetailViewController else { return cardCell! }

        self.addChildViewController(cardDetailVC)
        cardCell?.cardCellView.addSubview((cardDetailVC.view)!)
        cardDetailVC.view.frame = (cardCell?.contentView.bounds)!
        cardDetailVC.didMove(toParentViewController: self)

        cardCell?.clipsToBounds = true

//        cardDetailVC?.view.frame = CGRect(x: 0, y: -100, width: UIScreen.main.bounds.width/2, height: 120)
//        cardDetailVC?.view.clipsToBounds = true

        cardDetailVC.cardImage.isHidden = true

        if indexPath.row < LevelStatusManager.shared.level! {

            cardDetailVC.cardImage.isHidden = false

        }

        return cardCell!
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let cardListY = scrollView.contentOffset.y
        let movingDistance = cardListY - (-255)
        self.delegate?.cardViewDisScroll(self, translation: movingDistance)

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let cell = collectionView.cellForItem(at: indexPath) else { return }

        guard let cardDetailVC = controllers[indexPath.row] as? CardDetailViewController else { return }

        self.selectedIndex = indexPath

        let itemSize = UIScreen.main.bounds.width/2

        cardDetailVC.view.removeFromSuperview()

        self.view.addSubview(cardDetailVC.view)

        let point = collectionView.convert(cell.frame.origin, to: self.view)

        self.selectedPoint = point

        cardDetailVC.view.frame = CGRect(origin: point, size: CGSize(width: itemSize, height: itemSize))

        self.view.bringSubview(toFront: cardDetailVC.view)

        cardDetailVC.delegate = self

        print("-----Point---------")
        print(point)

        UIView.animate(withDuration: 0.3) {
            cardDetailVC.view.frame = self.view.frame
            cardDetailVC.changeContraintToFullScreen()
        }

    }

}

extension CardListViewController: CardDetailDelegate {

    func cardDetailDidTransition(controller: CardDetailViewController) {

        guard let selectedVC = controllers[(selectedIndex?.row)!] as? CardDetailViewController else { return }

        guard let selectedCell = self.listCollectionView.cellForItem(at: selectedIndex!) as? CardCollectionViewCell else { return }

        let point = listCollectionView.convert(selectedCell.frame.origin, to: view)

        let itemSize = UIScreen.main.bounds.width/2

        UIView.animate(withDuration: 0.3, animations: {

            selectedVC.view.frame = CGRect(origin: point, size: CGSize(width: itemSize, height: itemSize))
            selectedVC.changeConstraintToCellSize()

        }) { _ in
            selectedVC.view.removeFromSuperview()
            selectedCell.addSubview(selectedVC.view)
            selectedVC.view.frame = selectedCell.contentView.frame
            selectedVC.backgroundView.alpha = 1
        }

    }

}
