//
//  RecordListViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/9.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation
import RealmSwift

protocol RecordListControllerDelegate: class {
    func recordViewDidScroll(_ controller: RecordListViewController, translation: CGFloat)
}

class RecordListViewController: UIViewController {

    @IBOutlet weak var recordTableView: UITableView!

    weak var delegate: RecordListControllerDelegate?

    var trackInfo: TrackInfo?

    var tracksInfo = [TrackInfo]()

    var infoArray: [Any] = []

    let designSetting = DesignSetting()

    let database = DBManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        recordTableView.separatorStyle = .none
        designSetting.designSetting(view: recordTableView)

        recordTableView.contentInset = UIEdgeInsets(top: 190, left: 0, bottom: 0, right: 0)
        recordTableView.contentOffset = CGPoint(x: 0, y: -190)

        setupTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        recordTableView.reloadData()
    }

    func setupTableView() {

        let nib = UINib(nibName: String(describing: RecordTableViewCell.self), bundle: nil)
        recordTableView.register(nib, forCellReuseIdentifier: String(describing: RecordTableViewCell.self))
        recordTableView.delegate = self
        recordTableView.dataSource = self

    }

}

extension RecordListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if LevelStatusManager.shared.level! - 1 <= 9 {
            return LevelStatusManager.shared.level!
        }

        return 10
        //Need to increase when level goes up
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = recordTableView.dequeueReusableCell(withIdentifier: String(describing: RecordTableViewCell.self), for: indexPath) as? RecordTableViewCell
        cell?.selectionStyle = .none

        //loading realm database depends on level
        let sortedArray = DBProvider.shared.sortedArray
        let info = sortedArray![indexPath.row]
        cell?.artist.text = info.artist
        cell?.title.text = info.trackName

        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let recordY = scrollView.contentOffset.y
        let distance = recordY - (-190)
        self.delegate?.recordViewDidScroll(self, translation: distance)
    }

}

//Need to ask Luke
extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
//        return flatMap { $0 as? T }
        let array = Array(self) as? [T]
        return array!
    }
}
