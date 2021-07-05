//
//  String+Extension.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/3/20.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    func lowercasingFirstLetter() -> String {
        return prefix(1).lowercased() + dropFirst()
    }
}
