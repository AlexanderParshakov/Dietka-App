//
//  ProductInfoViewCell.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/3/20.
//

import UIKit

final class ProductPreviewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(withProductInfo productElement: ProductElement) {
        contentView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        let productPreview = ProductPreview.make(productElement: productElement)
        contentView.addSubview(productPreview)
        productPreview.pin(to: contentView, withTopBottomOffset: 10, left: 15, right: 15)
        productPreview.setSlightShadow()
        productPreview.layer.cornerRadius = 10
    }
}
