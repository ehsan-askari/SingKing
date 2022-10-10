//
//  CharactersView.swift
//  SingKing
//
//  Created by Ehsan Askari on 10/9/22.
//

import SwiftUI

struct CharactersView: View {
    
    @EnvironmentObject var charactersViewModel: CharactersViewModel
    
    private var characters: [Character] {
        if let filteredCharacters = charactersViewModel.filteredCharacters {
            return filteredCharacters
        }
        return charactersViewModel.characters ?? []
    }
    
    var body: some View {
        
        List {
            ForEach(characters, id: \.id) { character in
                CharacterView(character: character)
            }
        }
        .navigationTitle(AppString.charactersTitle.value)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $charactersViewModel.searchText)
        .overlay(alignment: .center, content: {
            if (charactersViewModel.isLoading) {
                ProgressView()
            }
            if (charactersViewModel.filteredCharacters?.isEmpty ?? false) {
                Text(AppString.noResults.value)
            }
        })
        .overlay(alignment: .bottomTrailing, content: {
            NavigationLink(destination: charactersViewModel.characterGameView) {
                Image(systemName: AppImage.System.game)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(Color.white)
                    .padding(12)
            }
            .frame(width: 60, height: 60)
            .background(Color.App.secondary)
            .clipShape(Circle())
            .padding(16)
        })
        .onAppear {
            charactersViewModel.getCharacters()
        }
        
    }
}
