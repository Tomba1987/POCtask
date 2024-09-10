//
//  LinkCard.swift
//  POCtask
//
//  Created by Tomislav Tomić on 07.09.2023..
//

import SwiftUI

struct LinkCard: View {
    
    var cardModel: CardViewModel
    
    var body: some View {
        HStack {
            Text(cardModel.title ?? "")
                .foregroundColor(.blue)
        }
    }
}
