//
//  UIFont+Extension.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/14/20.
//

import UIKit

extension UIFont {
    static var mediumPrimaryFont: UIFont {
        return .systemFont(ofSize: 18, weight: .medium)
    }
    static var semiboldPrimaryFont: UIFont {
        return .systemFont(ofSize: 18, weight: .semibold)
    }
    static var semiboldTitleFont: UIFont {
        return .systemFont(ofSize: 21, weight: .semibold)
    }
    static var boldMainTitleFont: UIFont {
        return .systemFont(ofSize: 32, weight: .bold)
    }
    static var boldPrimaryFont: UIFont {
        return .systemFont(ofSize: 18, weight: .bold)
    }
    static var boldSecondaryFont: UIFont {
        return .systemFont(ofSize: 15, weight: .bold)
    }
    static var secondaryFont: UIFont {
        return .systemFont(ofSize: 15, weight: .regular)
    }
}


struct RobotoFont {
    static let regular = "Roboto-Regular"
    static let medium = "Roboto-Medium"
    static let bold = "Roboto-Bold"
    static let italic = "Roboto-Italic"
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    static var isOverrided: Bool = false

    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: RobotoFont.regular, size: size)!
    }
    
    @objc class func myMediumSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: RobotoFont.medium, size: size)!
    }

    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: RobotoFont.bold, size: size)!
    }

    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: RobotoFont.italic, size: size)!
    }

    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage":
            fontName = RobotoFont.regular
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            fontName = RobotoFont.bold
        case "CTFontObliqueUsage":
            fontName = RobotoFont.italic
        default:
            fontName = RobotoFont.regular
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }

    class func overrideInitialize() {
        guard self == UIFont.self, !isOverrided else { return }

        // Avoid method swizzling run twice and revert to original initialize function
        isOverrided = true

        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }

        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }

        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:))) {
            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
        }

        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}
