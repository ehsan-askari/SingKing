//
//  StringExtension.swift
//  SingKing
//
//  Created by Ehsan Askari on 10/10/22.
//

import Foundation

extension String {
    
    public var asURL: URL? {
        return URL(string: self)
    }
    
}
