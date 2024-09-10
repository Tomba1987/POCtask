//
//  SquareCard.swift
//  POCtask
//
//  Created by Tomislav Tomić on 07.09.2023..
//

import SwiftUI

struct SquareCard: View {
    
    var cardModel: CardViewModel
    
    var body: some View {
        
        AsyncImage(url: URL(string: cardModel.image ?? "")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            ImageNotLoadingView()
        }
    }
}
