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

    var propImages: [UIImage] = []

    weak var delegate: CardListControllerDelegate?

    lazy var controllers: [UIViewController] = [
        UIStoryboard(name: "CardDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: CardDetailViewController.self)),
        UIStoryboard(name: "CardDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: CardDetailViewController.self)),
        UIStoryboard(name: "CardDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: CardDetailViewController.self)),
        UIStoryboard(name: "CardDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: CardDetailViewController.self)),
        UIStoryboard(name: "CardDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: CardDetailViewController.self)),
        UIStoryboard(name: "CardDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: CardDetailViewController.self)),
        UIStoryboard(name: "CardDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: CardDetailViewController.self)),
        UIStoryboard(name: "CardDetail", bundle: nil).instantiateViewController(withIdentifier: String(describing: CardDetailViewController.self))
    ]

    let transitionAnimation = TransitionAnimation()

    let designSetting = DesignSetting()

    var cardDetailVC: CardDetailViewController?

    var selectedIndex: IndexPath?

    var selectedPoint: CGPoint?

    var cell: UICollectionViewCell?

    var cardFlag: Bool?

    override func viewDidLoad() {

        super.viewDidLoad()

        setupCollectionView()

        setupCollectionLayout()

        designSetting.designSetting(view: listCollectionView)

        cardFlag = false

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if cardFlag == false {
            listCollectionView.reloadData()
        }

    }

    private func setupCollectionView() {

        let nib = UINib(nibName: String(describing: CardCollectionViewCell.self), bundle: nil)
        listCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: CardCollectionViewCell.self))
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.contentInset = UIEdgeInsets(top: 190, left: 0, bottom: 0, right: 0)
        listCollectionView.contentOffset = CGPoint(x: 0, y: -190)

    }

    private func setupCollectionLayout() {

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

        guard let cardCell = listCollectionView.dequeueReusableCell(
                                    withReuseIdentifier: String(describing: CardCollectionViewCell.self),
                                    for: indexPath) as? CardCollectionViewCell
        else { return UICollectionViewCell() }

        let uriManager = SpotifyUrisManager.createManagerFromFile()

        guard let cardDetailVC = controllers[indexPath.row] as? CardDetailViewController else { return cardCell }

        self.addChildViewController(cardDetailVC)

        cardCell.cardCellView.addSubview((cardDetailVC.view)!)

        cardDetailVC.view.frame = cardCell.contentView.bounds

        cardDetailVC.didMove(toParentViewController: self)

        cardDetailVC.cardView.isHidden = true

        cardCell.clipsToBounds = true

        cardCell.isUserInteractionEnabled = false

        cardDetailVC.cardImage.image = UIImage(named: uriManager.uris[indexPath.row].image)

        cardDetailVC.cardContentLabel.text = uriManager.uris[indexPath.row].hint

        if indexPath.row < LevelStatusManager.shared.level! {

            cardDetailVC.cardView.isHidden = false

            cardDetailVC.shadowView.isHidden = true

            cardCell.isUserInteractionEnabled = true

        }

        return cardCell
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

        UIView.animate(withDuration: 0.35,
                       animations: {
                            cardDetailVC.view.frame = self.view.frame
                            cardDetailVC.changeContraintToFullScreen()
                            collectionView.isUserInteractionEnabled = false
                            self.cardFlag = true},
                       completion: { _ in
                            cardDetailVC.startToMoveContent()
        })

    }

    func createImageAnimation(total: Int, imageRefix: String) -> [UIImage] {

        var imageArray: [UIImage] = []

        for imageCount in 0..<total {
            let imageName = "\(imageRefix)\(imageCount).png"
            let image = UIImage(named: imageName)!

            imageArray.append(image)
        }

        return imageArray

    }

    func animate(imageView: UIImageView, images: [UIImage]) {

        imageView.animationImages = images
        imageView.animationDuration = 0.8
        imageView.animationRepeatCount = 0
        imageView.startAnimating()

    }

}

extension CardListViewController: CardDetailDelegate {

    func cardDetailDidTransition(controller: CardDetailViewController) {

        guard let selectedVC = controllers[(selectedIndex?.row)!] as? CardDetailViewController else { return }

        guard let selectedCell = self.listCollectionView.cellForItem(at: selectedIndex!) as? CardCollectionViewCell else { return }

        let point = listCollectionView.convert(selectedCell.frame.origin, to: view)

        let itemSize = UIScreen.main.bounds.width / 2

        UIView.animate(withDuration: 0.35,
                       animations: {

                            selectedVC.view.frame = CGRect(origin: point, size: CGSize(width: itemSize, height: itemSize))
                            selectedVC.changeConstraintToCellSize() },

                       completion: { [weak self] _ in

                            selectedVC.view.removeFromSuperview()
                            selectedCell.addSubview(selectedVC.view)
                            selectedVC.view.frame = selectedCell.contentView.frame
                            selectedVC.backgroundView.alpha = 1
                            self?.listCollectionView.isUserInteractionEnabled = true
                            self?.cardFlag = false
                            self?.listCollectionView.reloadData()

        })

    }

}
