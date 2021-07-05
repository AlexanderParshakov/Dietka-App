//
//  PrimaryMediumLabel.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/14/20.
//

import UIKit

final class MediumLabel: UILabel {
    override var font: UIFont! {
        get {
            return .mediumPrimaryFont
        }
        set { }
    }
}

final class BoldLabel: UILabel {
    override var font: UIFont! {
        get {
            return .boldPrimaryFont
        }
        set { }
    }
}
