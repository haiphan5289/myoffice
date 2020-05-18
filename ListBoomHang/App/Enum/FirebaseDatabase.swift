//
//  FirebaseDatabase.swift
//  ListBoomHang
//
//  Created by MacbookPro on 4/24/20.
//  Copyright © 2020 MacbookPro. All rights reserved.
//

import Foundation
import Firebase
import UIKit

enum FirebaseTable {
    case listPhone
    
    var table: String {
        switch self {
        case .listPhone:
            return "listPhone"
        }
    }
}

class FirebaseDatabase {
    static var instance = FirebaseDatabase()
    var ref: DatabaseReference = Database.database().reference()
    var storage = Storage.storage().reference()
}
