//
//  CharacterGameView.swift
//  SingKing
//
//  Created by Ehsan Askari on 10/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterGameView: View {
    
    @EnvironmentObject var characterGameViewModel: CharacterGameViewModel
    @State private var characterName = ""
    @State private var isCorrect: Bool? = nil
    
    private var mainButtonTitle: String {
        if let isCorrect = isCorrect {
            return isCorrect ? AppString.correct.value : AppString.incorrect.value
        }
        return AppString.submit.value
    }
    
    private var mainButtonColor: Color {
        if let isCorrect = isCorrect {
            return isCorrect ? Color.green : Color.red
        }
        return Color.blue
    }
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .center, spacing: 16){
                
                WebImage(url: characterGameViewModel.randomCharacter?.img.asURL, options: WebImage.getDefaultOptions())
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                    .background(Color.gray.opacity(0.1))
                
                TextField(AppString.guessName.value, text: $characterName)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .multilineTextAlignment(.center)
                    .padding(16)
                    .background(Color.gray.opacity(0.1))
                    .padding(16)
                    .disabled(isCorrect != nil)
                
                Button(mainButtonTitle) {
                    isCorrect = characterGameViewModel.checkCharacterName(text: characterName)
                }
                .foregroundColor(mainButtonColor)
                .padding(16)
                .disabled(isCorrect != nil || characterName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                .opacity(characterName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.5 : 1.0)
                .onLongPressGesture {
                    if (isCorrect == nil)  {
                        characterName = characterGameViewModel.randomCharacter?.name ?? ""
                    }
                }
                
                Text(isCorrect != nil ? ">>> " + ( characterGameViewModel.randomCharacter?.name ?? "") + " <<<" : "")
                    .frame(height: 25)
                
                
                Spacer()
                
                Button(AppString.next.value) {
                    isCorrect = nil
                    characterName = ""
                    characterGameViewModel.getRandomCharacter()
                }
                .padding(16)
                
            }
            .padding([.leading, .trailing], 16)
            
        }
        .navigationTitle(AppString.characterGame.value)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            characterGameViewModel.getRandomCharacter()
        }
        
    }
}
