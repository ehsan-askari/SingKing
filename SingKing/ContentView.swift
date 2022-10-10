//
//  ContentView.swift
//  SingKing
//
//  Created by Ehsan Askari on 10/9/22.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            CharactersView().environmentObject(CharactersViewModel())
        }
    }
    
}
