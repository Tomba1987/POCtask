//
//  TableListViewModel.swift
//  POCtask
//
//  Created by Tomislav Tomić on 30.08.2023..
//

import Foundation
import SwiftUI
import Combine

class TableListViewModel: ObservableObject {
    
    @Published var lists = ListOfListsViewModel(lists: [])
    var cardFactory: CardFactory
    
    var dataModel: TableListDataModel
    
    var cancellable = Set<AnyCancellable>()
    
    init(dataModel: TableListDataModel, cardFactory: CardFactory) {
        self.dataModel = dataModel
        self.cardFactory = cardFactory
    }
    
    func loadDataModelIntoViewModel() {
        
        dataModel.loadDataModel()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("TableList Data model loaded!")
                case.failure(let error):
                    print("TableList Data model loading failed with error: \(error.localizedDescription)")
                }
            } receiveValue: { microApp in
                
                let lists = microApp.data.children?.first?.children?.compactMap { listData in
                    self.returnListViewModel(from: listData)
                } ?? []
                
                //self.lists.lists = lists
                self.lists = ListOfListsViewModel(lists: lists)
            }
            .store(in: &cancellable)
    }
    
    func returnListViewModel(from listData: MicroAppChildren) -> ListViewModel? {
        guard let cards = listData.children?.map({ card in
            CardViewModel(title: card.properties.text?.title?.title ?? "",
                          image: card.properties.images?.mobile ?? "",
                          layout: card.properties.layout ?? "",
                          description: card.properties.text?.description?.title ?? "",
                          endpoint: card.properties.navigation?.clientRequest.endpoint ?? "")
        }), !cards.isEmpty else { return nil }
        
        let orientation = ScrollOrientation(rawValue: listData.properties.orientation ?? "horizontal") ?? .horizontal
        let mode = ListMode(rawValue: listData.properties.mode ?? "default") ?? .def
        let columns = listData.properties.columnsNumber?.mobilePortrait ?? nil
        
        let listViewModel = ListViewModel(cards: cards,
                                          headLine: listData.properties.headLines?.slot1.text ?? "",
                                          cardHeight: listData.properties.cardSize?.mobile.cardHeight ?? 0,
                                          cardWidth: listData.properties.cardSize?.mobile.cardWidth ?? 0,
                                          cardFactory: self.cardFactory,
                                          orientation: orientation,
                                          columns: columns,
                                          mode: mode)
        
        return listViewModel
    }
}
