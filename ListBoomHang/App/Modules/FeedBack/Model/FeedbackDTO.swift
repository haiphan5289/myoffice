//
//  TipsDTO.swift
//  ListBoomHang
//
//  Created by MacbookPro on 5/24/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

struct FeedbackDate: Codable {
    let userName: String?
    let rate: Int?
    let content: String?
    let imagePhone: String?
    
    enum CodingKeys: String, CodingKey {
        case rate ,content, imagePhone, userName
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rate = try values.decodeIfPresent(Int.self, forKey: .rate)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        imagePhone = try values.decodeIfPresent(String.self, forKey: .imagePhone)
    }
}

