//
//  AccessTokenModel.swift
//  POCtask
//
//  Created by Tomislav Tomić on 22.08.2023..
//

import Foundation

struct AccessTokenModel: Codable {
    var data: TokenDataModel
}

struct TokenDataModel: Codable {
    var accessToken: String
    var cacheHash: String
    var userCacheHash: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case cacheHash = "cache_hash"
        case userCacheHash = "user_cache_hash"
    }
}
