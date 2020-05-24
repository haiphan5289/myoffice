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

class TipsApple: UIViewController {

    private let tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    var listTips: [TipsData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        setupRX()
    }
    private func setupRX() {
        
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TipsAppleCell") as! TipsAppleCell
        cell.updateUI(model: self.listTips[indexPath.row])
        return cell
    }
    
    
}
