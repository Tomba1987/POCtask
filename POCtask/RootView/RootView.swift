//
//  RootView.swift
//  POCtask
//
//  Created by Tomislav Tomić on 22.08.2023..
//

import SwiftUI
import Combine

struct RootView: View {
    
    @ObservedObject var viewModel: RootViewModel
    
    var body: some View {
        VStack {
            TabView {
                ForEach(viewModel.listOfTabs, id: \.self) { tab in
                    viewModel.router.route(to: tab,
                                           networkManager: viewModel.networkManager,
                                           factory: viewModel.factory,
                                           cardFactory: viewModel.cardFactory)
                        .tabItem {
                            Label(tab.clientRequest.endpoint.dropFirst(5), systemImage: "bell")
                        }
                }
            }
        }
        .onAppear {
            if viewModel.listOfTabs.isEmpty { viewModel.loadDataModelIntoViewModel() }
        }
    }
}

