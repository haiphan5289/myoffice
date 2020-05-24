//
//  TipsAppleCell.swift
//  ListBoomHang
//
//  Created by MacbookPro on 5/24/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit

class TipsAppleCell: UITableViewCell {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var vContent: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.applyShadowAndRadius(sizeX: 0, sizeY: 3, shadowRadius: 6, shadowColor: CustomColor.black16two.color)
        vContent.radiusShadow(radius: 10)
        self.imgAvatar.clipToBoundAndRadius(radius: 30)
        self.imgAvatar.backgroundColor = .red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateUI(model: TipsData ) {
        self.lbTitle.text = model.title
        self.lbContent.text = model.content
    }
    
}
