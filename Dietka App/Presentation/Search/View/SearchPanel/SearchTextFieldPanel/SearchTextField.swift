//
//  SearchTextField.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/14/20.
//

import UIKit

final class SearchTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    init() {
        super.init(frame: CGRect())
        
        self.font = .systemFont(ofSize: 20)
        let placeholder = "Search products, dishes, or diets..."
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                        attributes: [NSAttributedString.Key.foregroundColor : UIColor.searchPlaceholder])
        self.textColor = .black
        self.tintColor = .searchCaret
        self.backgroundColor = .none
        self.returnKeyType = .search
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
