//
//  PromoHeroCard.swift
//  POCtask
//
//  Created by Tomislav Tomić on 07.09.2023..
//

import SwiftUI

struct PromoHeroCard: View {
    
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
                Text(cardModel.title ?? "N/A")
                    .background(.black)
                    .padding()
                    .foregroundColor(.white)
                    .font(.title)
                Spacer()
                Text(cardModel.description ?? "N/A")
                    .background(.black)
                    .padding()
                    .foregroundColor(.gray)
                Spacer()
            }
        }
    }
}

struct ImageNotLoadingView: View {
    var body: some View {
        Color.gray
            .cornerRadius(10)
    }
}
