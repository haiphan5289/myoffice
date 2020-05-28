//
//  FeedBacckVC.swift
//  ListBoomHang
//
//  Created by MacbookPro on 5/18/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Firebase

class FeedBacckVC: UIViewController {

    private let tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    private let disposebag = DisposeBag()
    private var ref: DatabaseReference!
    private var listFeedBack: [FeedbackDate] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        tableView.delegate = self
        tableView.dataSource = self
        let xibCell = UINib(nibName: "FeedbBackCell", bundle:  nil)
        tableView.register(xibCell, forCellReuseIdentifier: "FeedbBackCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        setupRX()
    }
    
    private func setupRX() {
        LoadingManager.instance.show()
        self.ref.child("\(FirebaseTable.listFeedBack.table)").observe(.childAdded) { (data) in
            if let user = self.convertDataSnapshotToCodable(data: data, type: FeedbackDate.self) {
                self.listFeedBack.append(user)
                self.tableView.reloadData()
                LoadingManager.instance.dismiss()
            }
        }
    }

}
extension FeedBacckVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listFeedBack.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedbBackCell") as! FeedbBackCell
        cell.updateUI(model: self.listFeedBack[indexPath.row])
        return cell
    }
    
    
}
 
