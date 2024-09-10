//
//  Factory.swift
//  POCtask
//
//  Created by Tomislav Tomić on 24.08.2023..
//

import Foundation
import SwiftUI
import Combine

class MicroAppFactory {
    
    func createMicroApp(for navigation: NavigationObject,
                        networkManager: NetworkManager,
                        router: Router,
                        cardFactory: CardFactory) -> AnyView {
        switch navigation.microAppType {
        case "navigation":
            let dataModel = DataModelFactory.createRootDataModel(networkManager: networkManager)
            let viewModel = ViewModelFactory.createRootViewModel(router: router,
                                                                 networkManager: networkManager,
                                                                 factory: self,
                                                                 data: dataModel,
                                                                 cardFactory: cardFactory)
            
            return AnyView(RootView(viewModel: viewModel))
        case "table-list":
            let dataModel = DataModelFactory.createTableListDataModel(for: navigation,
                                                                      networkManager: networkManager)
            let viewModel = ViewModelFactory.createTableListViewModel(data: dataModel,
                                                                      cardFactory: cardFactory)
            return AnyView(TableListMicroApp(viewModel: viewModel))
        case "settings":
            return AnyView(SettingsView())
        case "explore":
            return AnyView(ExploreView())
        default:
            return AnyView(EmptyView())
        }
    }
}

class ViewModelFactory {
    static func createRootViewModel(router: Router,
                                    networkManager: NetworkManager,
                                    factory: MicroAppFactory,
                                    data: RootDataModel,
                                    cardFactory: CardFactory) -> RootViewModel {
        return RootViewModel(router: router,
                             networkManager: networkManager,
                             factory: factory,
                             dataModel: data,
                             cardfactory: cardFactory)
    }
    
    static func createTableListViewModel(data: TableListDataModel,
                                         cardFactory: CardFactory) -> TableListViewModel {
        return TableListViewModel(dataModel: data,
                                  cardFactory: cardFactory)
    }
}

class DataModelFactory {
    static func createTableListDataModel(for navigation: NavigationObject,
                                         networkManager: NetworkManager) -> TableListDataModel {
        return TableListDataModel(networkManager: networkManager,
                                  endpoint: navigation.clientRequest.endpoint)
    }
    
    static func createRootDataModel(networkManager: NetworkManager) -> RootDataModel {
        return RootDataModel(networkManager: networkManager)
    }
}
