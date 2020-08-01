//
//  TipsApple.swift
//  ListBoomHang
//
//  Created by MacbookPro on 5/24/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Firebase

class TipsApple: UIViewController {

    private let tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    var listTips: [TipsData] = []
    private var ref: DatabaseReference = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        visualize()
        setupRX()
    }
}
extension TipsApple {
    private func visualize() {
        tableView.delegate = self
        tableView.dataSource = self
        let xibCell = UINib(nibName: "TipsAppleCell", bundle:  nil)
        tableView.register(xibCell, forCellReuseIdentifier: "TipsAppleCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    private func setupRX() {
        LoadingManager.instance.show()
        self.ref.child("\(FirebaseTable.tips.table)").observe(.childAdded) { [weak self] (data) in
            guard let wSelf = self else { return }
            if let user = wSelf.convertDataSnapshotToCodable(data: data, type: TipsData.self) {
                wSelf.listTips.append(user)
                wSelf.tableView.reloadData()
                LoadingManager.instance.dismiss()
            }
        }
    }
}
extension TipsApple: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listTips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TipsAppleCell") as! TipsAppleCell
        cell.updateUI(model: self.listTips[indexPath.row])
        return cell
    }
    
    
}
