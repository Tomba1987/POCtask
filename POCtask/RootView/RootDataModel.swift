//
//  RootDataModel.swift
//  POCtask
//
//  Created by Tomislav Tomić on 05.09.2023..
//

import Foundation
import Combine

class RootDataModel {
    var networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func loadDataModel() -> AnyPublisher<CompilerResponse, Error> {
        return networkManager.requestEndpoint(url: networkManager.config?.entryPoint.navigation.request.endpoint ?? "")
    }
}
