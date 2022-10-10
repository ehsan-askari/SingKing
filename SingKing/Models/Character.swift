//
//  Character.swift
//  SingKing
//
//  Created by Ehsan Askari on 10/9/22.
//

import Foundation

struct Character: Codable {
    
    let id: Int
    let name: String
    let img: String
    
    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case name
        case img
    }
    
}
