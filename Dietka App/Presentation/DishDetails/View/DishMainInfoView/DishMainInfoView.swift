//
//  DishMainInfo.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/6/20.
//

import UIKit

final class DishMainInfoView: UIView, NibLoadable {
    
    @IBOutlet private var circleView: UIView!
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var weightLabel: UILabel!
    @IBOutlet private var separator: UIView!
    
    @IBOutlet private var caloriesLabel: UILabel!
    @IBOutlet private var fatLabel: UILabel!
    @IBOutlet private var proteinLabel: UILabel!
    @IBOutlet private var carbsLabel: UILabel!
    
    @IBOutlet private var imageContainer: UIView!
    @IBOutlet private var imageView: UIImageView!
    
    static func make(dishInfo: Dish) -> DishMainInfoView {
        let dishMainInfo = DishMainInfoView.loadFromNib()
        
        dishMainInfo.titleLabel.text = dishInfo.title.safe()
        dishMainInfo.titleLabel.font = .boldMainTitleFont
        dishMainInfo.titleLabel.textColor = .searchCaret
        
        dishMainInfo.caloriesLabel.text = "Calories: \(dishInfo.calories.safeString())"
        dishMainInfo.fatLabel.text = "Fat: \(dishInfo.fat.safeString())"
        dishMainInfo.proteinLabel.text = "Protein: \(dishInfo.protein.safeString())"
        dishMainInfo.carbsLabel.text = "Carbs: \(dishInfo.carbs.safeString())"
        dishMainInfo.weightLabel.text = "\(dishInfo.weight.safeString())g"
        
        dishMainInfo.imageView.image = dishInfo.image
        dishMainInfo.imageView.makeRoundWithBorder()
        
        dishMainInfo.imageContainer.layer.cornerRadius = dishMainInfo.imageContainer.frame.height / 2
        dishMainInfo.imageContainer.setSlightShadow()
        
        dishMainInfo.circleView.alpha = 0
        dishMainInfo.circleView.layer.cornerRadius = dishMainInfo.circleView.frame.width / 2
        dishMainInfo.circleView.setSlightShadow()
        
        return dishMainInfo
    }
    
    func fadeCircle(isHidden: Bool, animated: Bool = true) {
        UIView.animate(withDuration: 0.4) {
            self.circleView.alpha = isHidden ? 0 : 1
        }
    }
}
