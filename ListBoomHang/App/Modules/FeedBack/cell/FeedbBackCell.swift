//
//  FeedbBackCell.swift
//  ListBoomHang
//
//  Created by MacbookPro on 5/18/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit
import Cosmos

class FeedbBackCell: UITableViewCell {

    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var vRating: CosmosView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbDes: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.applyShadowAndRadius(sizeX: 0, sizeY: 3, shadowRadius: 6, shadowColor: CustomColor.black16two.color)
        vContent.radiusShadow(radius: 10)
        self.imgAvatar.clipToBoundAndRadius(radius: 35)
        self.imgAvatar.backgroundColor = .red
        self.lbDes.text = "backgroundColor backgroundColor backgroundColor backgroundColor backgroundColor backgroundColor backgroundColor backgroundColor backgroundColor backgroundColor backgroundColor backgroundColor backgroundColor backgroundColor backgroundColor backgroundColor backgroundColor backgroundColor backgroundColor backgroundColor backgroundColor "
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
