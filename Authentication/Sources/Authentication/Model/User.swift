//
//  User.swift
//  
//
//  Created by Catalin Palade on 25/09/2022.
//

import Foundation
import LocalStorage

struct User: Codable, Equatable, Storeable {
    
    let username: String
    let password: String
    
    var storeData: Data? {
        let encoder = JSONEncoder()
        let encoded = try? encoder.encode(self)
        return encoded
    }
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    init?(storeData: Data?) {
        guard let storeData = storeData else { return nil }
        let decoder = JSONDecoder()
        guard let decoded = try? decoder.decode(User.self, from: storeData) else { return nil }
        self = decoded
    }
}
