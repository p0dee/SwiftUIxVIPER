//
//  Tweet.swift
//  VIPERSample
//
//  Created by Takeshi Tanaka on 2020/07/25.
//

import Foundation

struct Repository: Codable {
    
    struct Owner: Codable {
        let login: String
    }
    
    let id: Int
    let name: String
    let description: String?
    let owner: Owner
    
}

extension Repository: Equatable {
    
    static func ==(lhs: Repository, rhs: Repository) -> Bool {
        lhs.id == rhs.id
    }
    
}
