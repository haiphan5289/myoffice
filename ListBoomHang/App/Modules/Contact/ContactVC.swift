//
//  ContactVC.swift
//  ListBoomHang
//
//  Created by MacbookPro on 5/24/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit

class ContactVC: UIViewController {

    @IBOutlet weak var lbContact: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lbContact.text = """
        Địa chỉ: 544 lê quang định, phường 7, gò vấp
        Số điện thoại liên hệ: 0703327758
        Link Facebook: https://www.facebook.com/hai.hai.7399
        Zalo: 0703327758
        """
    }

}
