//
//  DietPlanStackView.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/17/20.
//

import UIKit

final class DietPlanStackView: UIStackView {
    
    private var isFollowing = false
    
    init(distinctDays: [Int], dietPlans: [DietPlan], isFollowing: Bool) {
        super.init(frame: CGRect())
        
        distinctDays.forEach { (dayNumber) in
            let dayDietPlans = dietPlans.filter{ $0.dayNumber == dayNumber }
            let dayView = DayView.make(dietPlans: dayDietPlans, areSwitchesHidden: !isFollowing)
            
            addArrangedSubview(dayView)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
