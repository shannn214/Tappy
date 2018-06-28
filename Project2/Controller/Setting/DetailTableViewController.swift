//
//  DetailViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/6/27.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import UIKit

class DetailTableViewController: UIViewController {

    @IBOutlet weak var detailTableView: UITableView!

    var selectedCellIndex: IndexPath?

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
        detailTableView.autoresizingMask = []

        let nib = UINib(nibName: String(describing: SettingDetailTableViewCell.self), bundle: nil)
        detailTableView.register(nib, forCellReuseIdentifier: String(describing: SettingDetailTableViewCell.self))
        let headerNib = UINib(nibName: String(describing: DetailHeaderTableViewCell.self), bundle: nil)
        detailTableView.register(headerNib, forCellReuseIdentifier: String(describing: DetailHeaderTableViewCell.self))

    }

}

extension DetailTableViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = detailTableView.dequeueReusableCell(withIdentifier: String(describing: SettingDetailTableViewCell.self)) as? SettingDetailTableViewCell,
              let headerCell = detailTableView.dequeueReusableCell(withIdentifier: String(describing: DetailHeaderTableViewCell.self)) as? DetailHeaderTableViewCell
        else { return UITableViewCell() }

        guard let info = sortedArray?[(selectedCellIndex?.row)!] else { return UITableViewCell() }

        switch indexPath.row {
        case 0:

            headerCell.detailCellImage.sd_setImage(with: URL(string: info.cover))

            return headerCell
        default:
            return cell
        }

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.row {
        case 0:
            return UIScreen.main.bounds.width * 0.9
        default:
            return 40
        }

    }

}
