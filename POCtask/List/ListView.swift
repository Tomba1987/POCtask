//
//  ListView.swift
//  POCtask
//
//  Created by Tomislav Tomić on 08.09.2023..
//

import SwiftUI

struct ListView: View {
    
    var viewModel: ListViewModel
    
    var body: some View {
        
        VStack {
            HStack {
                Text(viewModel.headLine ?? "")
                    .padding()
                Spacer()
            }
            
            if let columns = viewModel.columns {
                LazyVGrid(columns: viewModel.returnGridItemList(numberOfColums: columns)) {
                    ForEach(viewModel.cards ?? [], id: \.id) { card in
                        viewModel.cardFactory.createCard(from: card)
                            .frame(width: viewModel.realWidth, height: viewModel.realHeight)
                    }
                }
            } else {
                if viewModel.mode == .carousel {
                    ScrollView(viewModel.returnScrollViewDirection()) {
                        LazyHStack {
                            ForEach(viewModel.cards ?? [], id: \.id) { card in
                                NavigationLink(destination: Text(card.endpoint ?? "endpoint=N/A")) {
                                    viewModel.cardFactory.createCard(from: card)
                                }
                                .frame(width: viewModel.realWidth, height: viewModel.realHeight)
                            }
                        }
                    }
                } else {
                    ScrollView(viewModel.returnScrollViewDirection()) {
                        LazyHStack {
                            ForEach(viewModel.cards ?? [], id: \.id) { card in
                                NavigationLink(destination: Text(card.endpoint ?? "endpoint=N/A")) {
                                    viewModel.cardFactory.createCard(from: card)
                                }
                                .frame(width: viewModel.realWidth, height: viewModel.realHeight)
                            }
                        }
                    }
                }
            }
        }
    }
}
