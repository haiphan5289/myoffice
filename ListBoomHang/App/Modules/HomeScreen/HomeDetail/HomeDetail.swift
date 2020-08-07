//
//  HomeDetail.swift
//  ListBoomHang
//
//  Created by Phan Hai on 02/08/2020.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit

class HomeDetail: UIViewController {

    @IBOutlet weak var imgIPhone: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var lbColor: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lnDescription: UITextView!
    var item: UserInfo?
    override func viewDidLoad() {
        super.viewDidLoad()
        visualize()
        updateUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
extension HomeDetail {
    private func visualize() {
        title = "Chi tiết điện thoại"
    }
    private func updateUI() {
        guard let item = self.item else {
            return
        }
        lbStatus.text = "Tình trạng: \(item.status ?? "")"
        lbPrice.text = "Giá: \(item.price ?? "")"
        lbTitle.text = item.type
        lbColor.text = "Màu sắc: \(item.color ?? "")"
        lnDescription.text = item.description
        self.imgIPhone.loadhinh(link: item.imagePhone ?? "")
    }
}
