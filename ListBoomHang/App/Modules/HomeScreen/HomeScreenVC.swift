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
    private var collectionView: UICollectionView!
    private var dataSource: [UserInfo] = []
    private var filterdata: [UserInfo] = []
    private let disposebag = DisposeBag()
    private var ref: DatabaseReference = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let dataDic: [String: Any] = ["type": "IPHONE 8 128",
        //                                      "status": "99%",
        //                                      "price":"7,800,000đ",
        //                                      "imagePhone": "https://scontent-xsp1-1.xx.fbcdn.net/v/t1.15752-9/101362394_3354650754554113_8347376094915067904_n.jpg?_nc_cat=105&_nc_sid=b96e70&_nc_ohc=PIULMwVeOgAAX-KdBWu&_nc_ht=scontent-xsp1-1.xx&oh=845401594b714272aa0e524eb9534e65&oe=5EF81857"]
        //
        //        FirebaseDatabase.instance.ref.child("\(FirebaseTable.listPhone.table)").childByAutoId().setValue(dataDic)
        //
        //        let dataDic1: [String: Any] = ["type": "IPHONE 8 Plus 64",
        //        "status": "99%",
        //        "price":"8,900,000đ",
        //        "imagePhone": "https://scontent-xsp1-1.xx.fbcdn.net/v/t1.15752-9/101190028_292625985100000_8454902181718392832_n.jpg?_nc_cat=103&_nc_sid=b96e70&_nc_ohc=Xu0sH3XCOGoAX8UAJYR&_nc_ht=scontent-xsp1-1.xx&oh=ccf861c9fd36dc070089ac722cf2786f&oe=5EF60758"]
        //        FirebaseDatabase.instance.ref.child("\(FirebaseTable.listPhone.table)").childByAutoId().setValue(dataDic1)
        
        visualize()
        setupRX()
    }
}
extension HomeScreenVC {
    private func visualize() {
        let tagCellLayout = UICollectionViewFlowLayout()
        tagCellLayout.minimumLineSpacing = 8
        tagCellLayout.minimumInteritemSpacing = 16
        tagCellLayout.scrollDirection = .vertical
        tagCellLayout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: tagCellLayout)
        
        collectionView.register(CellProduct.nib, forCellWithReuseIdentifier: CellProduct.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.searchBar.snp.bottom)
        }
        self.collectionView.backgroundColor = .white
    }
    private func setupRX() {
        LoadingManager.instance.show()
        self.ref.child("\(FirebaseTable.listPhone.table)").observe(.childAdded) { (data) in
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
        
//        Observable.of(self.dataSource).bind(to: collectionView.rx.items) { (collectionView, row, element) in
//            let indexPath = IndexPath(row: row, section: 0)
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellProduct.identifier, for: indexPath) as! CellProduct
//            cell.updateUI(model: self.dataSource[indexPath.row])
//            return cell
//        }
//        .disposed(by: disposebag)
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
