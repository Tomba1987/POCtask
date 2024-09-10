//
//  FeaturedHeroCard.swift
//  POCtask
//
//  Created by Tomislav Tomić on 07.09.2023..
//

import SwiftUI

struct FeaturedHeroCard: View {
    
    var cardModel: CardViewModel
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: cardModel.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ImageNotLoadingView()
            }
            
            VStack {
                Spacer()
                Text(cardModel.title ?? "")
                    .background(.black)
                    .padding()
                    .foregroundColor(.white)
                    .font(.title)
                Spacer()
                Text(cardModel.description ?? "")
                    .background(.black)
                    .padding()
                    .foregroundColor(.gray)
                Spacer()
            }
        }
    }
}
