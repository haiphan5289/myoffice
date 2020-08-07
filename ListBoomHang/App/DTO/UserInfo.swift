//
//  UserInfo.swift
//  ListBoomHang
//
//  Created by MacbookPro on 4/26/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import UIKit

struct UserInfo: Codable {
    let status: String?
    let type: String?
    let price: String?
    let imagePhone: String?
    let color: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case status ,type, price, imagePhone, color, description
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        imagePhone = try values.decodeIfPresent(String.self, forKey: .imagePhone)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }
}
