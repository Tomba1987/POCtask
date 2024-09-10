//
//  POCtaskApp.swift
//  POCtask
//
//  Created by Tomislav Tomić on 22.08.2023..
//

import SwiftUI
import Combine

@main
struct POCtaskApp: App {
    
    @StateObject var appLauncher = AppLauncher()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if ConfigStorage.shared.config == nil {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .controlSize(.large)
                } else {
                    displayRoot()
                }
                
            }
            .onAppear {
                appLauncher.launch()
            }
        }
    }
    
    func displayRoot() -> AnyView {
        guard let navigation = appLauncher.networkManager.config else { return AnyView(ProgressView()) }
        
        return appLauncher.microAppFactory.createMicroApp(for: navigation.entryPoint.navigation,
                                                   networkManager: appLauncher.networkManager,
                                                   router: appLauncher.router,
                                                   cardFactory: appLauncher.cardFactory)
    }
}

class AppLauncher: ObservableObject {
    
    let networkManager = NetworkManager()
    let microAppFactory = MicroAppFactory()
    let cardFactory = CardFactory()
    let router = Router()
    
    @Published var isLoaded = false
    
    func launch() {
        print("Launching App!")
        
        loadConfig(networkManager: networkManager)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("Completion finished, App is ON!")
                case .failure(let error):
                    print("Completion failed with error: \(error.localizedDescription)")
                }
            } receiveValue: { result in
                ConfigStorage.shared.config = result.config
                
                guard let config = ConfigStorage.shared.config else { return }
                
                self.networkManager.setupConfig(config: config)
                self.isLoaded = true
            }
            .store(in: &networkManager.cancellable)
    }
    
    func loadConfig(networkManager: NetworkManager) -> AnyPublisher<ConfigResponse, Error> {
        guard let url = URL(string: "Config URL goes here") else {
            print("Invalid Config URL!")
            return Empty(completeImmediately: false).eraseToAnyPublisher()
        }
        
        return networkManager.request(url: url)
    }
}
