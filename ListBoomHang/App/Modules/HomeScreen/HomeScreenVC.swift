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
    private var isSearching: Bool = false
    private var ref: DatabaseReference = Database.database().reference()
    private var tap: UITapGestureRecognizer = UITapGestureRecognizer()
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
//        collectionView.collectionViewLayout = CustomLayout()
        collectionView.register(CellProduct.nib, forCellWithReuseIdentifier: CellProduct.identifier)
//        if let layout = collectionView.collectionViewLayout as? CustomLayout{
//            layout.layoutDelegate = self
//        }
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
            guard let text = value, text.count > 0 else {
                self.isSearching = false
                self.collectionView.reloadData()
                return
            }
            self.isSearching = true
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
        
        self.tap.rx.event.bind { _ in
            self.view.endEditing(true)
        }.disposed(by: disposebag)
    }
    private func uploadData() {
        let url = URL(string: "https://facebook.com/messaging/lightspeed/media_fallback/?entity_id=330298721431268&entity_type=3&width=2048&height=2048&access_token=EAAGaiDLOH2MBAMeZAnppZCgaXI1hjtsdvYbbsDROSOLCBKIsGzWr9fR8FxIzZCkK3wGYcusPi6rpwe1kDBcjY7dmuKXS7o8EZAPpnhZBENZC0sTdZAXaR0uwtZCLC9OSmLUTEYjSDsmyIBwwpRI9VdXZAIb1Vfo9WuZANM8mCBPEvaUpavSgAxFbO6")
        guard let url1 = url else {
            return
        }
        do {
            let data = try Data(contentsOf: url1)
            // Create a reference to the file you want to upload
            let storageRef = Storage.storage().reference()
            let riversRef = storageRef.child("images/iphone7Plus32.jpg")

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
                let dataDic: [String: Any] = ["type": "IPHONE 7 Plus 32",
                                              "status": "99%",
                                              "price":"6,2222,222 đ",
                                              "imagePhone": downloadURL.absoluteString,
                                              "color": "Trắng - Đen - Vàng - Đỏ",
                                              "description": """
                   Đánh giá chi tiết iPhone 7 Plus 32GB

                   iPhone 7 Plus dường như là sản phẩm được Apple chăm chút để vượt xa iPhone 7, trở thành sản phẩm rất đáng để nâng cấp so với iPhone 6s Plus khi được nâng cấp thêm camera kép cùng chức năng chụp chân dung xoá phông cực "hot". Không chỉ vậy, nâng cấp đáng giá khác như tốc độ xử lý nhanh hơn, chống nước, bụi, loa ngoài sống động... Tất cả đã tạo nên một sản phẩm hàng đầu tuyệt vời.

                    

                   Thiết kế hoàn thiện hơn

                    



                    

                   Về thiết kế, vẫn là nhôm nguyên khối liền lạc nhưng iPhone 7 Plus đã có những nét thay đổi tinh tế khi đưa hai dải ăng-ten lên sát hai cạnh trên dưới, đồng thời bỏ đi jack cắm tai nghe 3.5 mm. Điểm nhấn ấn tượng nhất về ngoại hình của iPhone 7 Plus là việc Apple bỏ đi màu xám không gian từng rất được ưa chuộng trên các model cũ để bổ sung thêm tùy chọn màu đen mờ (màu đen bóng Jet Black chỉ có trên iPhone 7 Plus bản 128/256 GB).

                    

                   Màn hình rộng 5.5 inch, sáng hơn, nhiều màu sắc hơn

                    



                    

                   iPhone 7 Plus cũng có màn hình rộng 5.5 inch độ phân giải 1080x1920 pixels tương tự iPhone 6s Plus, như vậy về kích thước tổng thể chúng ta không có gì thay đổi. Tuy nhiên, tấm nền màn hình mới đã được bổ sung thêm 25% độ sáng, đạt mức cao nhất 625 nits cùng khả năng tái tạo màu sắc, gam màu rộng hơn và hỗ trợ 3D Touch.

                    

                   Nút Home cảm ứng lực hoàn toàn mới

                    



                    

                   Với chiếc điện thoại thế hệ mới, Apple đã "xoá sổ" hoàn toàn nút bấm vật lý trên màn hình iPhone. Giờ đây nút Home ở vị trí cũ đã trở thành cảm ứng, khi bạn nhấn xuống nó vẫn cảm nhận được lực nhấn và sẽ rung nhẹ để bạn biết rằng bạn đã tương tác. Apple đã sử dụng Taptic Engine trên Force Touch của Macbook cho chiếc iPhone mới này. Mặc dù vậy phím Home vẫn có cảm biến vân tay Touch ID và tích hợp nhiều tính năng bảo mật.

                    

                   Camera chất lượng đột phá như máy ảnh chuyên nghiệp

                    



                    

                   iPhone 7 Plus đi kèm với một camera kép độ phân giải đồng thời 12 MP, trong số đó có một ống kính góc rộng khẩu độ lên đến f/1.8 và một ống kính zoom (tele) lên đến 10x, cùng tính năng ổn định hình ảnh quang học tự động. Nó cũng bao gồm một đèn flash 2 tông màu và đèn flash quad-LED. Camera iPhone 7 Plus hỗ trợ quay film 4K 60fps, chụp xóa phông, chụp trước lấy nét sau như một máy ảnh chuyên nghiệp. Camera trước độ phân giải 7 MP, chụp selfie tốt hơn và tự động chống rung. Bên cạnh đó, iOS 10 cũng cho phép người dùng iPhone 7 Plus chỉnh sửa, chọn lựa ảnh từ Live Photos, lưu ảnh ở định dạng RAW.

                    

                   Tính năng chống nước tiện lợi

                    



                    

                   Có thể nói tính năng chống nước là điều làm hài lòng nhất các tín đồ nhà Táo. Với tiêu chuẩn chống nước IP67 sẽ giúp iPhone mới có thể sống ở độ sâu 1 mét nước trong 30 phút, vậy là từ nay bạn sẽ quên đi nỗi lo về thấm nước trên iPhone 7 Plus khi đi trong trời mưa hay lỡ tay rớt nước.

                    

                   Hiệu năng vượt trội với chip A10 Fusion mới

                    



                    

                   iPhone 7 Plus sử dụng chip A10 Fusion 4 lõi, 64-bit với tốc độ cực nhanh. Apple công bố con chip này có hiệu năng xử lý cao hơn 40% so với chip A9 và gấp 2 lần so với chip A8. Đặc biệt là nó còn cao gấp 120 lần so với iPhone đời đầu. Đi cùng đó là sự nâng cấp về bộ nhớ trong, phiên bản 16 GB trước đây đã bị loại bỏ, thay vào đó chúng ta sẽ có bộ nhớ trong ban đầu từ để thoải mái lưu trữ.

                    

                   Âm thanh sống động cùng loa stereo

                    

                   Loa ngoài trên iPhone 7 Plus bất ngờ được nâng cấp khi từ dạng đơn lên loa kép Stereo, với một loa nằm ở cạnh đáy và một nằm ở cạnh trên, cho âm lượng sống động gấp hai lần trên iPhone 6s.

                    

                   Tăng thời lượng sử dụng pin

                    

                   Theo công bố từ Apple, iPhone 7 Plus có khả năng sử dụng liên tục trong thời gian hơn 1 ngày, với 60 giờ lướt web không dây và 13 giờ sử dụng mạng LTE. Tăng hơn so với iPhone 6s Plus và đảm bảo sử dụng cho cả ngày dài.
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
        if isSearching {
            return self.filterdata.count
        }
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellProduct.identifier, for: indexPath) as! CellProduct
        if isSearching {
            cell.updateUI(model: self.filterdata[indexPath.row])
            return cell
        }
        cell.updateUI(model: self.dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.bounds.width - 48) / 2 , height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HomeDetail(nibName: "HomeDetail", bundle: nil)
        vc.item = self.dataSource[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
}
//extension HomeScreenVC: CustomLayoutDelegate {
//  func heightFor(index: Int) -> CGFloat {
//
//      //Implement your own logic to return the height for specific cell
//      return CGFloat(max(1, index) * 50)
//  }
//}
