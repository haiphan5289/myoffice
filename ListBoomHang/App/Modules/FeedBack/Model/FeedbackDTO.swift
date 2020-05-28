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
    let avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case rate ,content, avatar, userName
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rate = try values.decodeIfPresent(Int.self, forKey: .rate)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
    }
}

