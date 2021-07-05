//
//  UIViewController+Extension.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/13/20.
//

import UIKit
import SnapKit

// MARK: - Shadow

extension UIView {
    func setSlightShadow() {
        setShadow(shadowColor: .darkGray, length: 3, opacity: 0.35)
    }
    
    func setMediumShadow() {
        setShadow(shadowColor: .darkGray, length: 5, opacity: 0.55)
    }
    
    private func setShadow(shadowColor: UIColor = .darkGray, length: CGFloat = 3, opacity: Float = 0.35) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: length, height:  length)
        self.layer.shadowRadius = length * 2
        
        if #available(iOS 12.0, *), traitCollection.userInterfaceStyle == .dark {
           self.layer.shadowOpacity = 0.0;
        }
        else {
            self.layer.shadowOpacity = opacity
        }
    }
}


// MARK: - Corners
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

// MARK: - Constraints
extension UIView {
    func pin(to view: UIView, withTopBottomOffset topBottomOffset: Int = 0, left: Int = 0, right: Int = 0) {
        self.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(topBottomOffset)
            make.bottom.equalTo(view.snp.bottom).inset(topBottomOffset)
            make.leading.equalTo(view.snp.leading).offset(left)
            make.trailing.equalTo(view.snp.trailing).inset(right)
        }
    }
}


//// MARK: - Gradient
//extension UIView {
//    func applyGradient(withColor color: GradientColor, cornerRadius: CGFloat = 0) {
//        self.backgroundColor = nil
//        self.layoutIfNeeded()
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = color.cgColors
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
//        gradientLayer.frame = self.bounds
//        gradientLayer.cornerRadius = cornerRadius
//
//        gradientLayer.name = "current"
//
//        gradientLayer.shadowColor = UIColor.darkGray.cgColor
//        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
//        gradientLayer.shadowRadius = 5.0
//        gradientLayer.shadowOpacity = 0.3
//        gradientLayer.masksToBounds = true
//        gradientLayer.bounds = self.bounds
//
//        if self is UIButton {
//            (self as! UIButton).contentVerticalAlignment = .center
//            (self as! UIButton).setTitleColor(UIColor.white, for: .normal)
//            (self as! UIButton).titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
//            (self as! UIButton).titleLabel?.textColor = UIColor.white
//        }
//
//        self.layer.insertSublayer(gradientLayer, at: 0)
//    }
//
//    func applyGradient(withColors colors: [CGColor], cornerRadius: CGFloat = 0) {
//        self.backgroundColor = nil
//        self.layoutIfNeeded()
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = colors
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
//        gradientLayer.frame = self.bounds
//        gradientLayer.cornerRadius = cornerRadius
//
//        gradientLayer.name = "current"
//
//        gradientLayer.shadowColor = UIColor.darkGray.cgColor
//        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
//        gradientLayer.shadowRadius = 5.0
//        gradientLayer.shadowOpacity = 0.3
//        gradientLayer.masksToBounds = true
//        gradientLayer.bounds = self.bounds
//
//        if self is UIButton {
//            (self as! UIButton).contentVerticalAlignment = .center
//            (self as! UIButton).setTitleColor(UIColor.white, for: .normal)
//            (self as! UIButton).titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
//            (self as! UIButton).titleLabel?.textColor = UIColor.white
//        }
//
//        self.layer.insertSublayer(gradientLayer, at: 0)
//    }
//}

// MARK: - Animation

extension UIView {
    func showAnimatedPress(withScale scale: CGFloat = 0.9) {
        UIView.animate(withDuration: 0.15, animations: {
            self.transformToScale(scale)
        }) { (_) in
            UIView.animate(withDuration: 0.15) {
                self.transformToIdentity()
            }
        }
    }
    
    func showAnimatedPress(withScale scale: CGFloat = 0.9, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.05, animations: {
            self.transformToScale(scale)
        }) { (_) in
            UIView.animate(withDuration: 0.05, animations: {
                self.transformToIdentity()
            }) { (_) in
                completion()
            }
        }
    }
    
    func transformToIdentity() {
        self.transform = CGAffineTransform.identity
    }
    
    func transformToScale(_ scale: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
}
