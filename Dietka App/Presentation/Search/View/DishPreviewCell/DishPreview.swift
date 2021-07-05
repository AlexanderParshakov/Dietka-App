//
//  DishInfoView.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/6/20.
//

import UIKit

final class DishPreview: UIView, NibLoadable {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var caloriesLabel: UILabel!
    @IBOutlet private var fatLabel: UILabel!
    @IBOutlet private var proteinLabel: UILabel!
    @IBOutlet private var carbsLabel: UILabel!
    @IBOutlet private var weightLabel: UILabel!
    
    @IBOutlet private var imageContainer: UIView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var labelContainerView: UIView!
    
    static func make(dishInfo: Dish) -> DishPreview {
        let dishInfoView = DishPreview.loadFromNib()
        
        dishInfoView.titleLabel.text = dishInfo.title
        dishInfoView.titleLabel.font = .mediumPrimaryFont
        dishInfoView.caloriesLabel.text = "Calories: \(dishInfo.calories.safeString())"
        dishInfoView.fatLabel.text = "Fat: \(dishInfo.fat.safeString())"
        dishInfoView.proteinLabel.text = "Protein: \(dishInfo.protein.safeString())"
        dishInfoView.carbsLabel.text = "Carbs: \(dishInfo.carbs.safeString())"
        dishInfoView.weightLabel.text = "\(dishInfo.weight.safeString())g"
        
        dishInfoView.layoutIfNeeded()
        dishInfoView.imageView.image = dishInfo.image
        dishInfoView.imageView.makeRoundWithBorder()
        
        dishInfoView.imageContainer.layer.cornerRadius = dishInfoView.imageContainer.frame.height / 2
        dishInfoView.imageContainer.setSlightShadow()
        
        dishInfoView.labelContainerView.layer.cornerRadius = 10
        dishInfoView.labelContainerView.setSlightShadow()
        
        
        return dishInfoView
    }
}

extension UIView {
    func makeRoundWithBorder() {
        self.clipsToBounds = true
        self.layer.cornerRadius = bounds.width / 2
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.white.cgColor
    }
}
