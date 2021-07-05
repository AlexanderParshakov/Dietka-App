//
//  CircleBackground.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/12/20.
//

import UIKit
import SnapKit

enum CircleBackgroundType {
    case splash
    case signIn
    case personal
    case addNew
    case explore
    case searchResult
    case dishInfo
}

final class CircleBackground: UIView {
    
    private(set) var firstCircleConfiguration: CircleConfiguration?
    private(set) var secondCircleConfiguration: CircleConfiguration?
    
    init(type: CircleBackgroundType) {
        super.init(frame: CGRect())
        
        drawCircles(forType: type)
        setupBackground()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCircles()
    }
    
    private func drawCircles(forType type: CircleBackgroundType) {
        switch type {
        case .splash:
            break
        case .signIn:
            break
        case .personal:
            break
        case .addNew:
            break
        case .explore:
            self.firstCircleConfiguration = CircleConfiguration(heightScale: 0.65,
                                                                ratio: 1550/557,
                                                                verticalConstraintType: .fromTop(-150),
                                                                horizontalConstraintType: .fromLeft(-210),
                                                                color: .heavierLight)
            self.secondCircleConfiguration = CircleConfiguration(heightScale: 0.5,
                                                                 ratio: 1450/451,
                                                                 verticalConstraintType: .fromBottom(500),
                                                                 horizontalConstraintType: .fromLeft(-250),
                                                                 color: .light)
            
        case .searchResult:
            break
        case .dishInfo:
            break
        }
    }
    
    private func setupBackground() {
        backgroundColor = .none
    }
}
