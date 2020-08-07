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
        NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification).bind { _ in
            Auth.auth().signIn(withEmail: "userkhach@gmail.com", password: "123456", completion: nil)
        }.disposed(by: disposebag)
    }
    private func uploadData() {
        let url = URL(string: "https://scontent-xsp1-2.xx.fbcdn.net/v/t1.15752-9/116899666_3074580902661954_2695654160561301153_n.jpg?_nc_cat=102&_nc_sid=b96e70&_nc_ohc=swZ_CpCSd1kAX9ljP6u&_nc_ht=scontent-xsp1-2.xx&oh=7ba50d4a59a435893cda147d669bc887&oe=5F4CD530")
        guard let url1 = url else {
            return
        }
        do {
            let data = try Data(contentsOf: url1)
            // Create a reference to the file you want to upload
            let storageRef = Storage.storage().reference()
            let riversRef = storageRef.child("images/iphone6Plus.jpg")

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
                let dataDic: [String: Any] = ["type": "IPHONE 6 Plus 16",
                                              "status": "99%",
                                              "price":"4,111,111 đ",
                                              "imagePhone": downloadURL.absoluteString,
                                              "color": "Trắng - Đen",
                                              "description": """
                    1. Đôi nét về iPhone 6 Plus
                    Vào ngày 09/09/2014, bên cạnh chiếc điện thoại iPhone 6 thì Apple cũng đồng thời giới thiệu cả chiếc iPhone 6 Plus. iPhone 6 Plus là sự kế thừa của chiếc điện thoại iPhone 5S, đánh dấu sự gia tăng kích thước vật lý màn hình và sự nâng cấp cả về hiệu năng, cấu hình, camera,...
                    Chỉ trong ngày đầu tiên, iPhone 6 Plus và iPhone 6 đã bán ra 4 triệu bản và hơn 6 triệu bản trong 2 ngày tiếp theo.

                    2. Điểm nổi bật của dòng điện thoại iPhone 6 Plus
                    2.1. Thiết kế
                    Về ngoại hình, chiếc iPhone 6 Plus có thiết kế khá tương tự với iPhone 6. Đó vẫn là thiết kế bo tròn các góc, được làm từ hợp kim nhôm cao cấp nguyên khối - một chất liệu thường được dùng trong ngành công nghiệp hàng không. Bởi thế, khi cầm trên tay các bạn sẽ cảm thấy máy rất chắc chắn, mạnh mẽ và cứng cáp.

                    giá iphone 6 plus 16gb

                    iPhone 6 Plus có thêm màu vàng hồng

                    Một thông tin iPhone 6 Plus khiến khá nhiều người vui mừng đó là trong phiên bản này, Apple đã tung ra nhiều màu sắc đa dạng hơn. Ngoài 3 màu bạc, xám và vàng đã có từ trước thì giờ đây máy còn có thêm cả màu vàng hồng. Đây cũng là màu máy được yêu thích nhất trong các màu của iPhone 6 Plus. Với 4 màu sắc này người dùng cũng có thêm nhiều sự lựa chọn cho mình.

                    2.2. Cấu hình
                    Theo thông tin chi tiết iPhone 6 Plus được công bố thì iPhone 6 Plus sẽ sử dụng con chip A8 64 bit 2 nhân Cyclone. So với các chip A7 và A6 trước đây thì chip A8 mạnh mẽ hơn hẳn, dễ nhận thấy nhất đó chính là xung nhịp được tăng lên 100 MHz.

                    Sau khi test thực tế cũng đã cho thấy iPhone 6 Plus thực sự hoạt động rất nhanh và hiệu quả, ngay cả khi thử tải các ứng dụng thực tế.

                    giá iphone 6 plus chính hãng

                    Điện thoại iPhone 6 Plus sử dụng chip A8

                    Một điểm nữa cần lưu ý đó là ở phiên bản iPhone 6 Plus này Apple đã nâng cấp màn hình rộng rãi hơn. Theo chi tiết iPhone 6 Plus mà chúng tôi nhận được thì kích thước màn hình của chiếc điện thoại này là 5.5 inch. Thêm vào đó, Apple còn trang bị thêm công nghệ cảm ứng lực thông minh 3D Touch. Các bạn chỉ cần chạm vào màn hình, tùy theo lực nhấn mà máy sẽ đưa ra các phản hồi lệnh khác nhau.

                    2.3. Camera
                    Một trong các yếu tố cũng có ảnh hưởng tới giá iPhone 6 Plus chính hãng, đó là camera. iPhone 6 Plus sở hữu cụm camera iSight với camera chính được nâng cấp lên 12MP giúp máy có thể bắt nét xa và thu ảnh sắc nét hơn. Ngoài ra, tính năng quay video 4K cũng khá ấn tượng.

                    Camera trước của iPhone 6 Plus có độ phân giải là 5MP. Nhờ được trang bị công nghệ xử lý ảnh hiện đại nên các bức ảnh chụp bằng camera trước cũng sinh động và sắc nét không kém.

                    2.4. Thời lượng pin
                    Mặc dù ở phiên bản iPhone 6 Plus dung lượng pin không lớn, chỉ 1.715 mAh. Tuy nhiên, bù lại thì chiếc máy này lại có chế độ tiết kiệm pin tốt nên thời lượng sử dụng máy vẫn đảm bảo khiến người dùng hài lòng.

                    giá iphone 6 plus 16g

                    Dung lượng pin không lớn nhưng lại rất tiết kiệm pin

                    3. Giá của iPhone 6 Plus như thế nào?
                    Thông tin iPhone 6 Plus tiếp theo mà chúng tôi muốn chia sẻ đó là về giá thành. Mức giá iPhone 6 Plus tại Việt Nam bản 16GB có giá chưa tới 5 triệu đồng.

                    4. Mua iPhone 6 Plus ở đâu an toàn, uy tín nhất
                    Nếu các bạn đã có quyết định mua iPhone 6 Plus thì có thể tìm tới  Chúng tôi - địa chỉ chuyên cung cấp điện thoại iPhone chính hãng. Khi mua hàng tại đây các bạn hoàn toàn không cần lo lắng về chất lượng sản phẩm. Bên cạnh đó, giá bán iPhone 6 Plus tại đây cũng rất cạnh tranh.

                    Trên đây là một số thông tin iPhone 6 Plus mà chúng tôi muốn chia sẻ tới các bạn. Hy vọng những thông tin này sẽ hữu ích, giúp bạn hiểu rõ hơn về chiếc iPhone 6 Plus.
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.bounds.width - 48) / 2 , height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HomeDetail(nibName: "HomeDetail", bundle: nil)
        vc.item = self.dataSource[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
