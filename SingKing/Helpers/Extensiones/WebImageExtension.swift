//
//  WebImageExtension.swift
//  SingKing
//
//  Created by Ehsan Askari on 10/9/22.
//

import SDWebImageSwiftUI

extension WebImage {
    static func getDefaultOptions() -> SDWebImageOptions {
        return [ .lowPriority, .continueInBackground]
    }
}
