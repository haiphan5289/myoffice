//
//  CellProduct.swift
//  ListBoomHang
//
//  Created by MacbookPro on 5/8/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit

class CellProduct: UICollectionViewCell {

    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbTyper: UILabel!
    @IBOutlet weak var imgPhone: UIImageView!
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var lbStt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.applyShadowAndRadius(sizeX: 0, sizeY: 3, shadowRadius: 6, shadowColor: CustomColor.black16two.color)
        vContent.radiusShadow(radius: 10)
        imgPhone.clipsToBounds = true
        imgPhone.layer.cornerRadius = 10
    }
    
    func updateUI(model: UserInfo) {
        lbStt.text = model.status
        lbPrice.text = model.price
        lbTyper.text = model.type
        self.imgPhone.loadhinh(link: model.imagePhone ?? "")
        
    }

}
