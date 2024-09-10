//
//  NavigationModel.swift
//  POCtask
//
//  Created by Tomislav Tomić on 22.08.2023..
//

import Foundation

struct ConfigResponse: Codable {
    var config: AppConfig
}

struct AppConfig: Codable {
    var serviceId: String
    var hardcodedEndpoints: HardcodedEndpointResponse
    var entryPoint: EntryPointResponse
    
    enum CodingKeys: String, CodingKey {
        case hardcodedEndpoints = "hardcoded_endpoints"
        case entryPoint = "entry_point"
        case serviceId
    }
}

struct HardcodedEndpointResponse: Codable {
    var compilerUrl: String
}

struct EntryPointResponse: Codable {
    var navigation: NavigationObject
}

struct NavigationResponse: Codable {
    var request: RequestResponse
}

struct RequestResponse: Codable, Hashable {
    var endpoint: String
}

struct CompilerResponse: Codable {
    var data: DataResponse
}

struct DataResponse: Codable {
    var type: String
    var children: [Children]
}

struct Children: Codable {
    var type: String
    var properties: Properties?
    var children: [Children]?
}

struct Properties: Codable {
    var navigation: NavigationObject?
}

struct NavigationObject: Codable, Hashable {
    var microAppType: String
    var clientRequest: ClientRequest
    var request: RequestResponse
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.microAppType = try container.decode(String.self, forKey: .microAppType)
        self.clientRequest = try container.decodeIfPresent(ClientRequest.self, forKey: .clientRequest) ?? ClientRequest(endpoint: "B")
        self.request = try container.decodeIfPresent(RequestResponse.self, forKey: .request) ?? RequestResponse(endpoint: "A")
    }
    
    enum CodingKeys: String, CodingKey {
        case microAppType = "micro_app_type"
        case clientRequest = "client_request"
        case request
    }
}

struct ClientRequest: Codable, Hashable {
    var endpoint: String
}

struct MicroAppText: Codable, Hashable {
    var title: MicroAppTitle?
    
    var description: MicroAppDescription?
}

struct MicroAppTitle: Codable, Hashable {
    var title: String?
}

struct MicroAppDescription: Codable, Hashable {
    var title: String
}

struct Headline: Codable, Hashable {
    var slot1: Slot1
}

struct Slot1: Codable, Hashable {
    var text: String?
}

struct CardImage: Codable, Hashable {
    var mobile: String?
}

struct CardSize: Codable, Hashable {
    var mobile: MobileCardSize
}

struct MobileCardSize: Codable, Hashable {
    var cardHeight: CGFloat?
    var cardWidth: CGFloat?
}

struct MicroAppResponse: Codable {
    var data: MicroAppData
}

struct MicroAppData: Codable {
    var type: String
    var properties: MicroAppProperties
    var children: [MicroAppChildren]?
}

struct MicroAppProperties: Codable {
    var pageType: String?
    var layout: String?
    var text: MicroAppText?
    var headLines: Headline?
    var images: CardImage?
    var cardSize: CardSize?
    var mode: String?
    var orientation: String?
    var navigation: NavigationObject?
    var columnsNumber: MicroAppColums?
    
    enum CodingKeys: String, CodingKey {
        case pageType
        case layout
        case text
        case headLines
        case images
        case cardSize
        case mode
        case orientation
        case navigation
        case columnsNumber = "columns_number"
    }
}

struct MicroAppChildren: Codable {
    var properties: MicroAppProperties
    var children: [MicroAppChildren]?
}

struct MicroAppColums: Codable {
    var mobilePortrait: Int?
    
    enum CodingKeys: String, CodingKey {
        case mobilePortrait = "mobile_portrait"
    }
}
