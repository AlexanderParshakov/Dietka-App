//
//  ProductInfoView.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/3/20.
//

import UIKit

final class ProductPreview: UIView, NibLoadable {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var caloriesLabel: UILabel!
    @IBOutlet private var proteinLabel: UILabel!
    @IBOutlet private var fatLabel: UILabel!
    @IBOutlet private var carbsLabel: UILabel!
    
    static func make(productElement: ProductElement) -> ProductPreview {
        let productInfoView = ProductPreview.loadFromNib()
        guard let productInfo = [productElement].toProductContents().first else { return productInfoView }
        
        productInfoView.titleLabel.text = productInfo.title
        productInfoView.titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        productInfoView.caloriesLabel.text = "Calories: \(productInfo.calories.safeString())"
        productInfoView.proteinLabel.text = "Protein: \(productInfo.protein.safeString())"
        productInfoView.fatLabel.text = "Fat: \(productInfo.fat.safeString())"
        productInfoView.carbsLabel.text = "Carbs: \(productInfo.carbs.safeString())"
        
        return productInfoView
    }
    
    static func make(ingredient: Ingredient) -> ProductPreview {
        let productInfoView = ProductPreview.loadFromNib()
        productInfoView.titleLabel.text = "Product\(arc4random())"
        productInfoView.titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        productInfoView.caloriesLabel.text = "Calories: \(ingredient.calories.safeString())"
        productInfoView.proteinLabel.text = "Protein: \(ingredient.protein.safeString())"
        productInfoView.fatLabel.text = "Fat: \(ingredient.fat.safeString())"
        productInfoView.carbsLabel.text = "Carbs: \(ingredient.carbs.safeString())"
        
        return productInfoView
    }
}
