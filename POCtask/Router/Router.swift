//
//  Router.swift
//  POCtask
//
//  Created by Tomislav Tomić on 22.08.2023..
//

import Foundation
import SwiftUI

protocol RouterProtocol {
    
    func route(to navigation: NavigationObject,
               networkManager: NetworkManager,
               factory: MicroAppFactory,
               cardFactory: CardFactory) -> AnyView
}

class Router: RouterProtocol {
    
    func route(to navigation: NavigationObject,
               networkManager: NetworkManager,
               factory: MicroAppFactory,
               cardFactory: CardFactory) -> AnyView {
        factory.createMicroApp(for: navigation, networkManager: networkManager, router: self, cardFactory: cardFactory)
    }
}
