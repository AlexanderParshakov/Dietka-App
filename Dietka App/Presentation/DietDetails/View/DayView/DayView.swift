//
//  DayView.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/17/20.
//

import UIKit

final class DayView: UIView, NibLoadable {
    
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var dayWrapperView: UIView!
    @IBOutlet private var mealsStackView: UIStackView!
    
    static func make(dietPlans: [DietPlan], areSwitchesHidden: Bool) -> DayView {
        let dayView = DayView.loadFromNib()
        
        if let dayNumber = dietPlans.first?.dayNumber {
            dayView.dayLabel.text = "Day \(dayNumber)"
            dayView.dayLabel.font = .boldPrimaryFont
        }
        
        for (index, dietPlan) in dietPlans.enumerated() {
            let isLast = index == dietPlans.count - 1
            let mealView = MealView.make(dietPlan: dietPlan,
                                         isSwitchHidden: areSwitchesHidden,
                                         isSeparatorHidden: isLast)
            dayView.mealsStackView.addArrangedSubview(mealView)
        }
        
        dayView.setSlightShadow()
        
        dayView.dayWrapperView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        dayView.layer.cornerRadius = 10
        dayView.mealsStackView.layer.cornerRadius = 10
        
        return dayView
    }
}
