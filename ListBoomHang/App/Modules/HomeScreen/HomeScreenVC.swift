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
//        uploadData()
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
        collectionView.collectionViewLayout = CustomLayout()
        collectionView.register(CellProduct.nib, forCellWithReuseIdentifier: CellProduct.identifier)
        if let layout = collectionView.collectionViewLayout as? CustomLayout{
            layout.layoutDelegate = self
        }
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
        NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification).bind { _ in
            Auth.auth().signIn(withEmail: "userkhach@gmail.com", password: "123456", completion: nil)
        }.disposed(by: disposebag)
    }
    private func uploadData() {
        let url = URL(string: "https://facebook.com/messaging/lightspeed/media_fallback/?entity_id=1137422649992681&entity_type=3&width=2048&height=2048&access_token=EAAGaiDLOH2MBAMeZAnppZCgaXI1hjtsdvYbbsDROSOLCBKIsGzWr9fR8FxIzZCkK3wGYcusPi6rpwe1kDBcjY7dmuKXS7o8EZAPpnhZBENZC0sTdZAXaR0uwtZCLC9OSmLUTEYjSDsmyIBwwpRI9VdXZAIb1Vfo9WuZANM8mCBPEvaUpavSgAxFbO6")
        guard let url1 = url else {
            return
        }
        do {
            let data = try Data(contentsOf: url1)
            // Create a reference to the file you want to upload
            let storageRef = Storage.storage().reference()
            let riversRef = storageRef.child("images/iphone6s16.jpg")

            // Upload the file to the path "images/rivers.jpg"
            let uploadTask = riversRef.putData(data, metadata: nil) { (metadata, error) in
              guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
              }
              // Metadata contains file metadata such as size, content-type.
              let size = metadata.size
              // You can also access to download URL after upload.
              riversRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                  // Uh-oh, an error occurred!
                  return
                }
                let dataDic: [String: Any] = ["type": "IPHONE 6S 16",
                                              "status": "99%",
                                              "price":"3,111,111 đ",
                                              "imagePhone": downloadURL.absoluteString,
                                              "color": "Trắng - Đen - Vàng",
                                              "description": """
                    Lúc 0 giờ đêm nay (ngày 9/9), Apple đã chính thức giới thiệu bộ đôi iPhone 6s và iPhone 6s Plus thế hệ mới nhất.

                    Đúng như dự đoán, chiếc iPhone 6s có thiết kế giữ nguyên từ phiên bản trước và được nâng cấp một số tính năng mới. Đáng chú ý nhất là màn hình cảm ứng nhận biết lực ấn được Apple gọi là 3D Touch (chạm 3 chiều). 3D Touch cho phép bạn ấn lên màn hình iPhone 6s để mở các menu mới, kích hoạt các đường dẫn (shortcut) và tương tác với thiết bị theo những cách thức mới.



                    iPhone 6s vẫn duy trì thiết kế tương tự với màn hình 4.7 inch và được bổ sung màu mới là vàng hồng. Màu vàng hồng trông rất hồng, nhất là khi nhìn ở nơi nhiều ánh sáng. Điện thoại này cũng được áp dụng nhiều vật liệu mới gồm khung máy bằng loại hợp kim do Apple tự chế tác và màn hình được phủ lớp kính mới được gọi Ion-X đã được dùng trước đó trên Apple Watch Sport.



                    3D Touch mang lại hai cách tương tác mới với iPhone 6s được Apple gọi là "peek" và "pop". "Peek" cho phép bạn nhấn vào các biểu tượng ứng dụng và những nút khác để mở ra các đường dẫn (shortcut) trực tiếp vào những tính năng nào đó. Chẳng hạn nhấn vào ứng dụng Camera sẽ đưa đến lựa chọn mở trực tiếp vào tính năng chụp ảnh tự sướng. Nhấn vào ứng dụng Facebook sẽ đưa đến lựa chọn cập nhật trạng thái, chụp ảnh, check in hay tìm kiếm. "Pop" cho phép bạn xem ảnh và video mà không cần mở chúng lên màn hình.



                    iPhone 6s được trang bị bộ vi xử lý 64-bit Apple A9 mới được tích hợp kèm cả vi xử lý chuyển động M9. Như thường lệ, Apple không công bố chi tiết về vi xử lý nhưng cho biết nó sẽ nhanh hơn 70% với tác vụ CPU và 90% với tác vụ GPU so với Apple A8 trên iPhone 6.



                    Apple cũng đưa vào iPhone 6s camera sau 12MP. Đây là lần đầu tiên Apple tăng độ phân giải của camera sau kể từ chiếc iPhone 4s ra mắt vào năm 2011. Apple cho biết camera 12MP này sẽ được cải thiện khả năng lấy nét tự động, có khả năng quay video 4K và một điều không thay đổi là cụm camera vẫn lồi ở phía sau.



                    Camera trước cũng thay đổi, tăng lên 5MP và dù không có đèn flash nhưng khi chụp thiếu sáng thì màn hình sáng lên gấp 3 lần để trợ sáng cho ảnh chụp. Độ sáng màn hình để trợ sáng cũng có thể tuỳ chỉnh màu để phù hợp với ánh sáng môi trường của bức ảnh chụp.
"""
                ]
                FirebaseDatabase.instance.ref.child("\(FirebaseTable.listPhone.table)").childByAutoId().setValue(dataDic)
              }
            }
        } catch let err {
            print(err.localizedDescription)
        }


//
//        let dataDic1: [String: Any] = ["type": "IPHONE 8 Plus 64",
//                                       "status": "99%",
//                                       "price":"8,900,000đ",
//                                       "imagePhone": "https://scontent-xsp1-1.xx.fbcdn.net/v/t1.15752-9/101190028_292625985100000_8454902181718392832_n.jpg?_nc_cat=103&_nc_sid=b96e70&_nc_ohc=Xu0sH3XCOGoAX8UAJYR&_nc_ht=scontent-xsp1-1.xx&oh=ccf861c9fd36dc070089ac722cf2786f&oe=5EF60758"]
//        FirebaseDatabase.instance.ref.child("\(FirebaseTable.listPhone.table)").childByAutoId().setValue(dataDic1)
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
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (self.view.bounds.width - 48) / 2 , height: 150)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HomeDetail(nibName: "HomeDetail", bundle: nil)
        vc.item = self.dataSource[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension HomeScreenVC: CustomLayoutDelegate {
  func heightFor(index: Int) -> CGFloat {

      //Implement your own logic to return the height for specific cell
      return CGFloat(max(1, index) * 50)
  }
}
