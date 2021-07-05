//
//  MealView.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/17/20.
//

import UIKit

final class MealView: UIView, NibLoadable {
    
    @IBOutlet private var typeLabel: UILabel!
    @IBOutlet private var dishName: UILabel!
    @IBOutlet private var dishImageView: UIImageView!
    @IBOutlet private var dishImageContainer: UIView!
    @IBOutlet private var mealSwitch: UISwitch!
    @IBOutlet private var caloriesLabel: UILabel!
    @IBOutlet private var bottomSeparator: UIView!
    
    static func make(dietPlan: DietPlan,
                     isSwitchActive: Bool = false,
                     isSwitchHidden: Bool = true,
                     isSeparatorHidden: Bool) -> MealView {
        let mealView = MealView.loadFromNib()
        
        mealView.typeLabel.text = dietPlan.meal?.rawValue
        mealView.dishName.text = dietPlan.dish?.dishName
        mealView.caloriesLabel.text = "\(String(dietPlan.dish?.kcal ?? 0))kCal"
        mealView.mealSwitch.onTintColor = .button
        mealView.mealSwitch.isHidden = isSwitchHidden
        mealView.mealSwitch.isOn = isSwitchActive
        
        if let urlString = dietPlan.dish?.picsURL,
           let url = URL(string: urlString),
           let data = try? Data(contentsOf: url) {
            mealView.dishImageView.image = UIImage(data: data)
            mealView.dishImageView.makeRoundWithBorder()
            
            mealView.dishImageContainer.layer.cornerRadius = mealView.dishImageContainer.frame.height / 2
            mealView.dishImageContainer.setSlightShadow()
        }
        
        mealView.layer.cornerRadius = 10
        mealView.bottomSeparator.isHidden = isSeparatorHidden
        mealView.bottomSeparator.backgroundColor = .primarySeparator
        
        return mealView
    }
}
