//
//  CharactersViewModel.swift
//  SingKing
//
//  Created by Ehsan Askari on 10/9/22.
//

import Foundation
import Combine
import SwiftUI

class CharactersViewModel: ObservableObject {
    
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var characters: [Character]? = nil
    @Published var searchText: String = ""
    @Published private(set) var filteredCharacters: [Character]? = nil
    private var anyCancellable : AnyCancellable?
    
    init() {
        anyCancellable = $searchText
            .filter({ (str) -> Bool in
                if !str.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    return true
                } else {
                    self.filteredCharacters = nil
                    return false
                }
            })
        //            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: searchCharacters(text:))
    }
    
    deinit {
        anyCancellable?.cancel()
        anyCancellable = nil
    }
    
    private func searchCharacters(text: String){
        filteredCharacters = characters?.filter({ $0.name.lowercased().contains(text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()) })
    }
    
    func getCharacters() {
        
        isLoading.toggle()
        
        APIManager.request(endpoint: API.Endpoint.characters, httpMethod: .get) { (result) in
            switch result {
            case .success(let data):
                if let characters = try? JSONDecoder().decode([Character].self, from: data) {
                    DispatchQueue.main.async {
                        self.isLoading.toggle()
                        self.characters = characters //.sorted(by: {$0.name < $1.name})
                    }
                }
            case .failure(let error):
                print(error)
                print(AppString.information.value)
                switch error {
                case .noConnection:
                    print(AppString.noConnection.value)
                case .forbidden://403
                    print(AppString.userNotFound.value)
                case .notFound://404
                    print(AppString.userNotFound.value)
                default:
                    print(AppString.unknownError.value)
                }
            }
        }
        
    }
    
    lazy var characterGameView: AnyView = {
        AnyView(CharacterGameView().environmentObject(CharacterGameViewModel()))
    }()
    
}
