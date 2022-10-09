//
//  AppString.swift
//  SingKing
//
//  Created by Ehsan Askari on 10/9/22.
//

import SwiftUI

enum AppString: String {
    
    case singKing
    
    var key: LocalizedStringKey {
        return LocalizedStringKey(self.rawValue)
    }
    
    var value: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
    func value(format: String) -> String {
        return String.localizedStringWithFormat(getLocalizable(key: self.rawValue), format)
    }
    
    private func getLocalizable(key: String) -> String {
        let bundle: Bundle = .main
        return bundle.localizedString(forKey: key, value: nil, table: "Localizable")
    }
}
