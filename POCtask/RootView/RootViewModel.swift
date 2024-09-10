//
//  RootViewModel.swift
//  POCtask
//
//  Created by Tomislav Tomić on 22.08.2023..
//

import Foundation
import Combine
import SwiftUI

class RootViewModel: ObservableObject {
    
    @Published var listOfTabs = [NavigationObject]()
    let router: Router
    let networkManager: NetworkManager
    
    let factory: MicroAppFactory
    
    let cardFactory: CardFactory
    
    let dataModel: RootDataModel
    
    var cancellable = Set<AnyCancellable>()
    
    init(router: Router,
         networkManager: NetworkManager,
         factory: MicroAppFactory,
         dataModel: RootDataModel,
         cardfactory: CardFactory) {
        self.router = router
        self.networkManager = networkManager
        self.factory = factory
        self.dataModel = dataModel
        self.cardFactory = cardfactory
    }
    
    func loadDataModelIntoViewModel() {
        
        dataModel.loadDataModel()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Root Data Model loaded!")
                case.failure(let error):
                    print("Root Data model loading failed with error: \(error.localizedDescription)")
                }
            } receiveValue: { (result: CompilerResponse) in
                for item in result.data.children {
                    for tab in item.children ?? [] {
                        if let navigation = tab.properties?.navigation {
                            self.listOfTabs.append(navigation)
                        }
                    }
                }
            }
            .store(in: &cancellable)
    }
}
