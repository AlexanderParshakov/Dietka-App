//
//  Optional+Extension.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/6/20.
//

extension Optional where Wrapped == Float {
    func safeString() -> String {
        guard let self = self else { return "" }
        return String(self)
    }
}

extension Optional where Wrapped == String {
    func safe() -> String {
        guard let self = self else { return "" }
        return String(self)
    }
}
