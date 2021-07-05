//
//  DietInfoCell.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/16/20.
//

import UIKit

final class DietPreviewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(withDiet diet: Diet) {
        contentView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        let dietPreview = DietPreview.make(diet: diet)
        contentView.addSubview(dietPreview)
        dietPreview.pin(to: contentView, withTopBottomOffset: 10, left: 15, right: 15)
        dietPreview.setSlightShadow()
        dietPreview.layer.cornerRadius = 10
    }
}

final class DietPreviewCollectionCell: UICollectionViewCell {
    
    public func set(withDiet diet: Diet) {
        contentView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        let dietPreview = DietPreview.make(diet: diet)
        contentView.addSubview(dietPreview)
        dietPreview.pin(to: contentView, withTopBottomOffset: 10, left: 15, right: 15)
        dietPreview.setSlightShadow()
        dietPreview.layer.cornerRadius = 10
    }
}
