//
//  Separator.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/13/20.
//

import UIKit


final class Separator: UIView {
    
    init(color: UIColor = .primarySeparator) {
        super.init(frame: CGRect())
        
        self.backgroundColor = color
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.width * 0.01
    }
}
