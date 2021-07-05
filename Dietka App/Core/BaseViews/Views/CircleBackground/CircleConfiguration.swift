//
//  CircleConfiguration.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/12/20.
//

import UIKit

enum CircleVerticalConstraintType {
    case fromTop(CGFloat)
    case fromBottom(CGFloat)
}
enum CircleHorizontalConstraintType {
    case fromLeft(CGFloat)
    case fromRight(CGFloat)
}

struct CircleConfiguration {
    let heightScale: CGFloat
    let ratio: CGFloat
    let verticalConstraintType: CircleVerticalConstraintType
    let horizontalConstraintType: CircleHorizontalConstraintType
    
    let color: UIColor
}
