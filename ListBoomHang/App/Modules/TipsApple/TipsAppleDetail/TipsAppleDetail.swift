//
//  TipsAppleDetail.swift
//  ListBoomHang
//
//  Created by Phan Hai on 08/08/2020.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit

class TipsAppleDetail: UIViewController {
    private var lbTitle: UILabel = UILabel(frame: .zero)
    private var tvDescription: UITextView = UITextView(frame: .zero)
    private var item: TipsData?
    override func viewDidLoad() {
        super.viewDidLoad()
        visualize()
    }
    convenience init(item: TipsData) {
        self.init()
        self.item = item
        updateUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Mẹo vặt Apple"
    }
}
extension TipsAppleDetail {
    private func visualize() {
        self.view.backgroundColor = .white
        
        lbTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        lbTitle.textAlignment = .center
        self.view.addSubview(lbTitle)
        
        lbTitle.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).inset(30)
            make.left.right.equalToSuperview().inset(16)
        }
        
        tvDescription.isEditable = false
        tvDescription.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        tvDescription.textAlignment = .left
        self.view.addSubview(tvDescription)
        
        tvDescription.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().inset(16)
            make.top.equalTo(lbTitle.snp.bottom).inset(-16)
        }
    }
    private func updateUI() {
        self.lbTitle.text = self.item?.title
        self.tvDescription.text = self.item?.content
    }
}
