//
//  ListOfListsView.swift
//  POCtask
//
//  Created by Tomislav Tomić on 08.09.2023..
//

import SwiftUI

struct ListOfListsView: View {
    
    var viewModel: ListOfListsViewModel
    
    var body: some View {
        ScrollView(.vertical) {
            ForEach(viewModel.lists, id: \.id) { list in
                ListView(viewModel: list)
            }
        }
    }
}
