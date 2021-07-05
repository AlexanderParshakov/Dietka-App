//
//  ExploreTitleLabel.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/13/20.
//

import UIKit

final class ExploreTitleLabel: UILabel {
    
    init() {
        super.init(frame: CGRect())
        
        self.text = "Explore"
        self.textColor = .white
        self.font = .boldSystemFont(ofSize: 44)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
