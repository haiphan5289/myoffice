//
//  HomeScreenCell.swift
//  ListBoomHang
//
//  Created by MacbookPro on 4/24/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit
import Kingfisher

class HomeScreenCell: UITableViewCell {

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var lbUserName: UILabel!
    @IBOutlet weak var lbNumberPhone: UILabel!
    @IBOutlet weak var avtarImg: UIImageView!
    @IBOutlet weak var lbDes: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.applyShadowAndRadius(sizeX: 0, sizeY: 3, shadowRadius: 6, shadowColor: CustomColor.black16two.color)
        vContent.radiusShadow(radius: 10)
//        self.backgroundColor = .red
        avtarImg.clipToBoundAndRadius(radius: 23)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateUI(model: UserInfo) {
//        self.lbUserName.text = model.userName
//        self.lbNumberPhone.text = model.numberPhone
//        self.lbDes.text = "\(model.strFB ?? "")\n\(model.description ?? "")"
//        DispatchQueue.main.async {
//            let img = UIImage().decodeBase64(toImage: model.avatarImage)
////            self.avtarImg.kf.set
//            self.avtarImg.image = img
//        }
//        self.avtarImg.loadhinh(link: model.avatarImage ?? "")
    }
//        let queue = DispatchQueue(label: "queue", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
//        queue.async {
//            if let url = URL(string: "https://imgur.com/cvTDioX") {
//                do {
//                    let data = try Data(contentsOf: url)
//                    DispatchQueue.main.async {
//                        self.avtarImg.image = UIImage(data: data)
//                    }
//                } catch let err {
//                    print(err.localizedDescription)
//                }
//            }
//        }
//    }
//            DispatchQueue.main.async {
//                    if let image_dowload = UIImage(data: data!){
////                        activies.stopAnimating()
//                        //tăng speed dowload
////                        image_Cache.setObject(image_dowload, forKey: link as AnyObject)
//                        self.avtarImg.image = image_dowload
//                }
//            }

//        }
//    }
//    func downloadFile(file: GTLDriveFile){
//        let url = "https://www.googleapis.com/drive/v3/files/\(file.identifier!)?alt=media"
//
//        let fetcher = drive.fetcherService.fetcherWithURLString(url)
//
//        fetcher.beginFetchWithDelegate(
//            self,
//            didFinishSelector: #selector(ViewController.finishedFileDownload(_:finishedWithData:error:)))
//    }
}
