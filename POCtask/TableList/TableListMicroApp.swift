//
//  HomeView.swift
//  POCtask
//
//  Created by Tomislav Tomić on 24.08.2023..
//

import SwiftUI
import Combine

struct TableListMicroApp: View {
    
    @ObservedObject var viewModel: TableListViewModel
    
    var body: some View {
        GeometryReader { geo in
            ListOfListsView(viewModel: viewModel.lists)
                .frame(width: geo.size.width, height: geo.size.height)
                .onAppear {
                    viewModel.loadDataModelIntoViewModel()
                }
        }
    }
}
