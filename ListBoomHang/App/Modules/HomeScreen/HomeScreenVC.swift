//
//  HomeScreenVC.swift
//  ListBoomHang
//
//  Created by MacbookPro on 4/24/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SVProgressHUD
import SnapKit
import Firebase


class HomeScreenVC: UIViewController, ActivityTrackingProgressProtocol {

    @IBOutlet weak var searchBar: UISearchBar!
//    private let tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    private var collectionView: UICollectionView!
    private var dataSource: [UserInfo] = []
    private var filterdata: [UserInfo] = []
    private let disposebag = DisposeBag()
    private var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        visualize()
        setupRX()
    }
    private func setupRX() {
        LoadingManager.instance.show()
        self.ref.child("\(FirebaseTable.listUser.table)").observe(.childAdded) { (data) in
            if let user = self.convertDataSnapshotToCodable(data: data, type: UserInfo.self) {
                self.dataSource.append(user)
                self.collectionView.reloadData()
                LoadingManager.instance.dismiss()
            }
        }
        
        self.searchBar.rx.text.bind { (value) in
            guard let text = value else { return }
            self.filterdata =  self.dataSource.filter { ($0.type?.contains(text) ?? true) }
            self.collectionView.reloadData()
        }.disposed(by: disposebag)
        
    }

    
    private func visualize() {
//        tableView.separatorStyle = .none
//        tableView.backgroundColor = .white
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(HomeScreenCell.nib, forCellReuseIdentifier: HomeScreenCell.identifier)
//
//
//        self.view.addSubview(tableView)
//        tableView.snp.makeConstraints { (make) in
//            make.left.right.bottom.equalToSuperview()
//            make.top.equalTo(self.searchBar.snp.bottom)
//        }
        let tagCellLayout = UICollectionViewFlowLayout()
        tagCellLayout.minimumLineSpacing = 8
        tagCellLayout.minimumInteritemSpacing = 16
        tagCellLayout.scrollDirection = .vertical
        tagCellLayout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: tagCellLayout)

        collectionView.register(CellProduct.nib, forCellWithReuseIdentifier: CellProduct.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.searchBar.snp.bottom)
        }
        self.collectionView.backgroundColor = .white
    }
}
extension HomeScreenVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellProduct.identifier, for: indexPath) as! CellProduct
        cell.updateUI(model: self.dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.bounds.width - 48) / 2 , height: 150)
    }
    
}

//}
//extension HomeScreenVC: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0.1
//    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0.1
//    }
//
//}
//extension HomeScreenVC: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if self.filterdata.count > 0 {
//            return self.filterdata.count
//        }
//        return self.dataSource.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: HomeScreenCell.identifier) as! HomeScreenCell
//        cell.updateUI(model: self.dataSource[indexPath.row])
//        return cell
//    }
//}
