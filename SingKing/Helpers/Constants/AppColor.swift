//
//  AppColor.swift
//  SingKing
//
//  Created by Ehsan Askari on 10/9/22.
//

import SwiftUI

fileprivate enum AppColorString: String {
    case Primary
    case Secondary
}

extension Color {
    
    struct App {
        static var primary: Color {
            Color(AppColorString.Primary.rawValue)
        }
        static var secondary: Color {
            Color(AppColorString.Secondary.rawValue)
        }
    }
    
}

