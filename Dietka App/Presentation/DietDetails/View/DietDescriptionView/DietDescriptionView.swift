//
//  DietDescriptionView.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/17/20.
//

import UIKit

final class DietDescriptionView: UIView, NibLoadable {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var bodyLabel: UILabel!
    
    static func make(body: String) -> DietDescriptionView {
        let dietDescriptionView = DietDescriptionView.loadFromNib()
        
        dietDescriptionView.titleLabel.font = .mediumPrimaryFont
        
        dietDescriptionView.bodyLabel.text = body
        dietDescriptionView.bodyLabel.font = .secondaryFont
        
        dietDescriptionView.layer.cornerRadius = 10
        dietDescriptionView.setSlightShadow()
        
        return dietDescriptionView
    }
}
