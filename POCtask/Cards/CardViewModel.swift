//
//  CardViewModel.swift
//  POCtask
//
//  Created by Tomislav Tomić on 08.09.2023..
//

import Foundation

struct CardViewModel: Identifiable {
    var id = UUID()
    var title: String?
    var image: String?
    var layout: String?
    var description: String?
    
    var endpoint: String?
}
