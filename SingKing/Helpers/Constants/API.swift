//
//  API.swift
//  SingKing
//
//  Created by Ehsan Askari on 10/9/22.
//

import Foundation

enum API {
    
#if DEBUG
    static let baseURL = "https://breakingbadapi.com/api"
#else
    static let baseURL = "https://breakingbadapi.com/api"
#endif
    
    static let defaultHeaders = ["Content-Type": "application/json"]
    
    enum Endpoint {
        static let ad = "/characters"
    }
}
