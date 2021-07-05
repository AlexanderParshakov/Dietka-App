//
//  CustomColors.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/12/20.
//

import UIKit

extension UIColor {
    
    struct SeparatorColorType {
        static let primarySeparator = UIColor.primarySeparator
        static let secondarySeparator = UIColor.secondarySeparator
    }
    
    private static func hexStringToUIColor (hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static var button: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "Button") ?? .black
        } else {
            return UIColor.hexStringToUIColor(hex: "128DE7")
        }
    }
    static var heavierLight: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "HeavierLight") ?? .black
        } else {
            return UIColor.hexStringToUIColor(hex: "6DB9F1")
        }
    }
    static var light: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "Light") ?? .black
        } else {
            return UIColor.hexStringToUIColor(hex: "3DA7F4").withAlphaComponent(0.66)
        }
    }
    static var primarySeparator: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "PrimarySeparator") ?? .black
        } else {
            return UIColor.hexStringToUIColor(hex: "E5E5E5")
        }
    }
    static var secondarySeparator: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "SecondarySeparator") ?? .black
        } else {
            return UIColor.hexStringToUIColor(hex: "000000").withAlphaComponent(0.54)
        }
    }
    static var searchCaret: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "SearchCaret") ?? .black
        } else {
            return UIColor.hexStringToUIColor(hex: "3DA7F4")
        }
    }
    static var searchPlaceholder: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "SearchPlaceholder") ?? .black
        } else {
            return UIColor.hexStringToUIColor(hex: "000000").withAlphaComponent(0.29)
        }
    }
}
