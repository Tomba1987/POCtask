//
//  CardFactory.swift
//  POCtask
//
//  Created by Tomislav Tomić on 07.09.2023..
//

import Foundation
import SwiftUI

class CardFactory {
    func createCard(from cardViewModel: CardViewModel) -> AnyView {
        switch cardViewModel.layout {
        case "promo_hero":
            return AnyView(PromoHeroCard(cardModel: cardViewModel))
        case "poster_card":
            return AnyView(PosterCard(cardModel: cardViewModel))
        case "circle_card":
            return AnyView(CircleCard(cardModel: cardViewModel))
        case "image_card":
            return AnyView(ImageCard(cardModel: cardViewModel))
        case "featured_hero":
            return AnyView(FeaturedHeroCard(cardModel: cardViewModel))
        case "square_card":
            return AnyView(SquareCard(cardModel: cardViewModel))
        case "link_card":
            return AnyView(LinkCard(cardModel: cardViewModel))
        default:
            return AnyView(EmptyView())
        }
    }
}
