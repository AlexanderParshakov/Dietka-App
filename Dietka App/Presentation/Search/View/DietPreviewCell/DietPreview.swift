//
//  DietInfoView.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/16/20.
//

import UIKit

final class DietPreview: UIView, NibLoadable {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var titleBackground: UIView!
    @IBOutlet private var firstImageContainer: UIView!
    @IBOutlet private var firstImageView: UIImageView!
    @IBOutlet private var firstCalorieLabel: UILabel!
    @IBOutlet private var secondImageContainer: UIView!
    @IBOutlet private var secondImageView: UIImageView!
    @IBOutlet private var secondCalorieLabel: UILabel!
    @IBOutlet private var thirdImageContainer: UIView!
    @IBOutlet private var thirdImageView: UIImageView!
    @IBOutlet private var thirdCalorieLabel: UILabel!
    
    
    static func make(diet: Diet) -> DietPreview {
        let dietPreview = DietPreview.loadFromNib()
        
        dietPreview.titleLabel.text = diet.dietName
        dietPreview.titleLabel.font = .semiboldTitleFont
        
        dietPreview.firstCalorieLabel.text = "\(String(diet.dietPlans?[0].dish?.kcal ?? 0))kCal"
        dietPreview.secondCalorieLabel.text = "\(String(diet.dietPlans?[1].dish?.kcal ?? 0))kCal"
        dietPreview.thirdCalorieLabel.text = "\(String(diet.dietPlans?[2].dish?.kcal ?? 0))kCal"
        
        
        dietPreview.firstImageView.makeRoundWithBorder()
        dietPreview.secondImageView.makeRoundWithBorder()
        dietPreview.thirdImageView.makeRoundWithBorder()
        
        dietPreview.firstImageContainer.layer.cornerRadius = dietPreview.firstImageContainer.frame.height / 2
        dietPreview.firstImageContainer.setSlightShadow()
        dietPreview.secondImageContainer.layer.cornerRadius = dietPreview.secondImageContainer.frame.height / 2
        dietPreview.secondImageContainer.setSlightShadow()
        dietPreview.thirdImageContainer.layer.cornerRadius = dietPreview.thirdImageContainer.frame.height / 2
        dietPreview.thirdImageContainer.setSlightShadow()
        
        if let urlString = diet.dietPlans?[0].dish?.picsURL,
           let url = URL(string: urlString),
           let data = try? Data(contentsOf: url) {
            dietPreview.firstImageView.image = UIImage(data: data)
        }
        
        if let urlString = diet.dietPlans?[1].dish?.picsURL,
           let url = URL(string: urlString),
           let data = try? Data(contentsOf: url) {
            dietPreview.secondImageView.image = UIImage(data: data)
        }
        
        if let urlString = diet.dietPlans?[2].dish?.picsURL,
           let url = URL(string: urlString),
           let data = try? Data(contentsOf: url) {
            dietPreview.thirdImageView.image = UIImage(data: data)
        }
        dietPreview.layer.cornerRadius = 10
        dietPreview.titleBackground.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        dietPreview.titleBackground.backgroundColor = .button
        dietPreview.setNeedsLayout()
        dietPreview.layoutIfNeeded()
        return dietPreview
    }
}
