//
//  DetailViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/27.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

protocol DetailDelegate: class {
    func detailDidScroll(translation: CGFloat)
}

class DetailTableViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!

    var selectedCellIndex: IndexPath?

    weak var detailDelegate: DetailDelegate?

    let sortedArray = DBProvider.shared.sortedArray

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func initialSetup() {

        detailTableView.separatorStyle = .none
        detailTableView.delegate = self
        detailTableView.dataSource = self

        detailTableView.rowHeight = UITableViewAutomaticDimension
        detailTableView.estimatedRowHeight = 100

        let nib = UINib(nibName: String(describing: SettingDetailTableViewCell.self), bundle: nil)
        detailTableView.register(nib, forCellReuseIdentifier: String(describing: SettingDetailTableViewCell.self))
        let headerNib = UINib(nibName: String(describing: DetailHeaderTableViewCell.self), bundle: nil)
        detailTableView.register(headerNib, forCellReuseIdentifier: String(describing: DetailHeaderTableViewCell.self))

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        self.detailDelegate?.detailDidScroll(translation: scrollView.contentOffset.y)

    }

}

extension DetailTableViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = detailTableView.dequeueReusableCell(withIdentifier: String(describing: SettingDetailTableViewCell.self)) as? SettingDetailTableViewCell,
              let headerCell = detailTableView.dequeueReusableCell(withIdentifier: String(describing: DetailHeaderTableViewCell.self)) as? DetailHeaderTableViewCell
        else { return UITableViewCell() }

        guard let info = sortedArray?[(selectedCellIndex?.row)!] else { return UITableViewCell() }

        let uriManager = SpotifyUrisManager.createManagerFromFile()
        let jsonData = uriManager.uris[(selectedCellIndex?.row)!]

        cell.selectionStyle = .none
        headerCell.selectionStyle = .none

        switch indexPath.row {
        case 0:

            headerCell.detailCellImage.sd_setImage(with: URL(string: info.cover))
            headerCell.headerTitle.text = jsonData.title

            return headerCell
        default:

            cell.detailContent.text = jsonData.content

            return cell
        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.row {
        case 0:
            return UIScreen.main.bounds.width * 0.9
        case 1:
            return UITableViewAutomaticDimension
        default:
            return 50
        }

    }

}
