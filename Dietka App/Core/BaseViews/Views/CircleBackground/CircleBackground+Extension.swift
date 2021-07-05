//
//  CircleBackground+Extension.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/13/20.
//

import SnapKit

extension CircleBackground {
    
    func updateCircles() {
        self.layer.sublayers?.removeAll()
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        var verticalOffset = CGFloat(0.0)
        var horizontalOffset = CGFloat(0.0)
        
        if let firstConfig = self.firstCircleConfiguration {
            verticalOffset = calculateVerticalOffset(withConstraintType: firstConfig.verticalConstraintType)
            horizontalOffset = calculateHorizontalOffset(withConstraintType: firstConfig.horizontalConstraintType)
            let path = UIBezierPath(ovalIn: CGRect(x: horizontalOffset,
                                                   y: verticalOffset,
                                                   width: screenWidth * firstConfig.heightScale * firstConfig.ratio,
                                                   height: screenHeight * firstConfig.heightScale))
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.isOpaque = true
            shapeLayer.fillColor = firstConfig.color.cgColor
            self.layer.addSublayer(shapeLayer)
        }
        if let secondConfig = self.secondCircleConfiguration {
            verticalOffset = calculateVerticalOffset(withConstraintType: secondConfig.verticalConstraintType)
            horizontalOffset = calculateHorizontalOffset(withConstraintType: secondConfig.horizontalConstraintType)
            let path = UIBezierPath(ovalIn: CGRect(x: horizontalOffset,
                                                   y: verticalOffset,
                                                   width: screenWidth * secondConfig.heightScale * secondConfig.ratio,
                                                   height: screenHeight * secondConfig.heightScale))
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.fillColor = secondConfig.color.cgColor
            self.layer.addSublayer(shapeLayer)
        }
    }
    
    private func calculateVerticalOffset(withConstraintType type: CircleVerticalConstraintType) -> CGFloat {
        switch type {
        case .fromTop(let topConstraint):
            return topConstraint
        case .fromBottom(let bottomConstraint):
            return UIScreen.main.bounds.height - bottomConstraint
        }
    }
    
    private func calculateHorizontalOffset(withConstraintType type: CircleHorizontalConstraintType) -> CGFloat {
        switch type {
        case .fromLeft(let leadingConstraint):
            return leadingConstraint
        case .fromRight(let trailingConstraint):
            return UIScreen.main.bounds.width - trailingConstraint
        }
    }
}
