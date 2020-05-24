//
//  TipsDTO.swift
//  ListBoomHang
//
//  Created by MacbookPro on 5/24/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

struct TipsData: Codable {
    let title: String?
    let content: String?
    let imagePhone: String?
    
    enum CodingKeys: String, CodingKey {
        case title ,content, imagePhone
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        imagePhone = try values.decodeIfPresent(String.self, forKey: .imagePhone)
    }
}

