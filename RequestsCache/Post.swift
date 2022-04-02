//
//  Post.swift
//  RequestsCache
//
//  Created by Alexander Avdacev on 2.04.22.
//

import Foundation

struct Post: Codable {
    
    let userId: Int
    let postId: Int
    let title: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case userId
        case postId = "id"
        case title
        case body
            
    }
}
