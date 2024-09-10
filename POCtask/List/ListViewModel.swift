//
//  ListViewModel.swift
//  POCtask
//
//  Created by Tomislav Tomić on 08.09.2023..
//

import Foundation
import SwiftUI

struct ListViewModel: Identifiable {
    var id = UUID()
    var cards: [CardViewModel]?
    var headLine: String?
    var cardHeight: CGFloat?
    var cardWidth: CGFloat?
    var cardFactory: CardFactory
    
    var orientation: ScrollOrientation
    
    var columns: Int?
    
    var mode: ListMode
    
    var realWidth: CGFloat {
        if cardWidth == 0 {
            return UIScreen.main.bounds.width
        } else {
            return cardWidth ?? 0
        }
    }
    
    var realHeight: CGFloat? {
        if cardHeight == 0 {
            return nil
        } else {
            return cardHeight ?? 0
        }
    }
    
    func returnScrollViewDirection() -> Axis.Set {
        switch orientation {
        case .vertical:
            return Axis.Set.vertical
        case .horizontal:
            return Axis.Set.horizontal
        }
    }
    
    func returnGridItemList(numberOfColums: Int) -> [GridItem] {
        var grids = [GridItem]()
        
        for _ in 0 ..< numberOfColums {
            grids.append(GridItem())
        }
        
        return grids
    }
}

enum ScrollOrientation: String {
    case horizontal
    case vertical
}

enum ListMode: String {
    case def = "default"
    case carousel
}
