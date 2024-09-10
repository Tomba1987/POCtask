//
//  ListOfListsViewModel.swift
//  POCtask
//
//  Created by Tomislav Tomić on 08.09.2023..
//

import Foundation

struct ListOfListsViewModel: Identifiable {
    var id = UUID()
    var lists: [ListViewModel]
}
