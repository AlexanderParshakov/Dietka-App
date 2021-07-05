//
//  SolidButton.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/14/20.
//

import UIKit

class SolidButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = .white
        self.layer.cornerRadius = self.frame.width * 0.16
    }
}
