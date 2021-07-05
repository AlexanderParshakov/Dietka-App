//
//  DishInfoViewCell.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/6/20.
//

import UIKit

final class DishPreviewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(withDishInfo dishInfo: Dish) {
        contentView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        let dishPreview = DishPreview.make(dishInfo: dishInfo)
        contentView.addSubview(dishPreview)
        dishPreview.pin(to: contentView, withTopBottomOffset: 10, left: 40, right: 20)
        dishPreview.layer.cornerRadius = 10
    }
}
