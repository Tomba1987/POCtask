//
//  TableListDataModel.swift
//  POCtask
//
//  Created by Tomislav Tomić on 04.09.2023..
//

import Foundation
import Combine

struct TableListDataModel {
    
    var networkManager: NetworkManager
    var endpoint: String
    
    func loadDataModel() -> AnyPublisher<MicroAppResponse, Error> {
        return networkManager.requestEndpoint(url: endpoint)
    }
}
