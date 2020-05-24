//
//  AddCustom.swift
//  ListBoomHang
//
//  Created by MacbookPro on 4/24/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SVProgressHUD
import Firebase

enum AddCustomImage: Int, CaseIterable {
    case user
    case numberPhone
    case facebook
    
    var img: UIImage? {
        switch self {
        case .user:
            return UIImage(named: "ic_user_black")
        case .numberPhone:
            return UIImage(named: "ic_phone_black")
        case .facebook:
            return UIImage(named: "ic_fb")
        }
    }
}

class AddCustom: UIViewController {

    @IBOutlet var vContent: [UIView]!    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfNumberPhone: UITextField!
    @IBOutlet weak var tfFaceBookStr: UITextField!
    @IBOutlet weak var btAddCustom: UIButton!
    private let disposebag = DisposeBag()
    private var tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    private var btImage: UIButton = UIButton(type: .system)
    private var imgBase64: String = ""
    private var isEnableButton: Bool = false
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        visualize()
        setupRX()
    }
    private func setupRX() {
        self.tvContent.rx.didBeginEditing.subscribe(onNext: { _ in
            if (self.tvContent.textColor == CustomColor.whiteseven83.color) {
                self.tvContent.text = ""
            }
            self.tvContent.textColor = CustomColor.blackthree.color
        }).disposed(by: disposebag)
        
        self.tvContent.rx.text.subscribe(onNext: { (value) in

        }).disposed(by: disposebag)
        
        let isUserName = self.tfUserName.rx.text.orEmpty.map { (value) -> Bool in
            return value.count > 0
        }
        
        let isNumberPhone = self.tfNumberPhone.rx.text.orEmpty.map { (value) -> Bool in
            return value.count > 0
        }
        
        let isFB = self.tfFaceBookStr.rx.text.orEmpty.map { (value) -> Bool in
            return value.count > 0
        }
        
        let isDecription = self.tvContent.rx.text.orEmpty.map { (value) -> Bool in
            return value.count > 0
        }
        
        Observable.combineLatest(isUserName, isNumberPhone, isFB, isDecription).map { (user, numberPhone, fb, des) -> Bool in
            return user && numberPhone && fb && des
        }.bind { (enable) in
            self.isEnableButton = enable
        }.disposed(by: disposebag)
        

        self.btAddCustom.rx.tap.bind(onNext: weakify { (wSelf) in
            guard let userName = wSelf.tfUserName.text,
                let numberPhone = wSelf.tfNumberPhone.text,
                let strFB = wSelf.tfFaceBookStr.text,
                let description = wSelf.tvContent.text else {
                self.showAlert()
                return
            }
            
            if !wSelf.isEnableButton {
                wSelf.showAlert()
            }
//            let userName: String?
//               let rate: Int?
//               let content: String?
//               let imagePhone: String?
            let dataDic: [String: Any] = ["content": strFB, "rate": 9, "userName":userName, "imagePhone": self.imgBase64]
            FirebaseDatabase.instance.ref.child("\(FirebaseTable.listFeedBack.table)").childByAutoId().setValue(dataDic)
        }).disposed(by: disposebag)
        
        self.tapGesture.rx.event.bind(onNext: weakify { (user, wSelf) in
            wSelf.view.endEditing(true)
        }).disposed(by: disposebag)
        
        self.btImage.rx.tap.bind { _ in
            let img: UIImagePickerController = UIImagePickerController()
            img.delegate = self
            img.sourceType = .photoLibrary
            img.allowsEditing = true
            self.present(img, animated: true, completion: nil)
        }.disposed(by: disposebag)
    }
    private func showPhotoLibrary(type: UIImagePickerController.SourceType) {
        let img: UIImagePickerController = UIImagePickerController()
        img.delegate = self
        img.sourceType = type
        img.allowsEditing = true
        self.present(img, animated: true, completion: nil)
    }
    private func visualize() {
        vContent.filter {
            $0.backgroundColor = CustomColor.whitefive.color
            $0.clipToBoundAndRadius(radius: 5)
            return true
        }
        tvContent.textColor = CustomColor.whiteseven83.color
        tvContent.text = "Nhập lí do boom hàng...."
        tvContent.layer.borderColor = CustomColor.warmgrey.color.cgColor
        tvContent.layer.borderWidth = 0.5
        tvContent.clipToBoundAndRadius(radius: 5)
        
        tfUserName.placeholder = "Nhập tên boom hàng"
        tfNumberPhone.placeholder = "Nhập sdt"
        tfFaceBookStr.placeholder = "Nhập tên FB or link FB"
        
        self.btAddCustom.backgroundColor = CustomColor.niceblue.color
        self.btAddCustom.clipToBoundAndRadius(radius: 5)
        
        self.avatarImage.image = UIImage(named: "avatar-placeholder")
        self.avatarImage.clipToBoundAndRadius(radius: 50)
        
        self.view.addGestureRecognizer(self.tapGesture)
        
        self.view.addSubview(self.btImage)
        self.btImage.snp.makeConstraints { (make) in
            make.edges.equalTo(self.avatarImage)
        }
    }
    private func showAlert() {
        let alert: UIAlertController = UIAlertController(title: "Thông báo", message: "Vui lòng điền đầy đủ thông tin để mọi người tham khảo", preferredStyle: .alert)
        let btCancel: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(btCancel)
        self.present(alert, animated: true, completion: nil)
    }

}
extension AddCustom: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage : UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.avatarImage.image = selectedImage
        self.imgBase64 = selectedImage.base64 ?? ""
        self.dismiss(animated: true, completion: nil)
    }
}
