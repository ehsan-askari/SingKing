//
//  CharacterGameViewModel.swift
//  SingKing
//
//  Created by Ehsan Askari on 10/10/22.
//

import Foundation
import Combine

class CharacterGameViewModel: ObservableObject {
    
    @Published private(set) var randomCharacter: Character? = nil
    
    func checkCharacterName(text: String) -> Bool {
        randomCharacter?.name.lowercased().contains(text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()) ?? false
    }
    
    func getRandomCharacter() {
        
        APIManager.request(endpoint: API.Endpoint.randomCharacter, httpMethod: .get) { (result) in
            switch result {
            case .success(let data):
                if let randomCharacters = try? JSONDecoder().decode([Character].self, from: data) {
                    DispatchQueue.main.async {
                        self.randomCharacter = randomCharacters.first
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
    
}
