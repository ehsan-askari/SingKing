//
//  CharacterView.swift
//  SingKing
//
//  Created by Ehsan Askari on 10/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterView: View {
    
    let character: Character
    
    var body: some View {
        
        HStack(spacing: 16) {
            
            WebImage(url: character.img.asURL, options: WebImage.getDefaultOptions())
                .resizable()
                .placeholder(Image(systemName: AppImage.System.person))
                .transition(.fade(duration: 0.5))
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70, alignment: .top)
                .foregroundColor(Color.gray)
                .clipShape(Circle())
            
            Text(character.name)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .frame(maxWidth: .infinity)
        
    }
}
