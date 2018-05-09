//
//  RecordListViewController.swift
//  Project2
//
//  Created by 尚靖 on 2018/5/9.
//  Copyright © 2018年 尚靖. All rights reserved.
//

import Foundation

class RecordListViewController: UIViewController {

    @IBOutlet weak var recordTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        recordTableView.contentInset = UIEdgeInsets(top: 260, left: 0, bottom: 0, right: 0)
        recordTableView.contentOffset = CGPoint(x: 0, y: -260)
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
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = recordTableView.dequeueReusableCell(withIdentifier: String(describing: RecordTableViewCell.self), for: indexPath) as? RecordTableViewCell

        return cell!
    }

}
