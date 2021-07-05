//
//  Dish.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/12/20.
//

import UIKit

struct Dish {
    let title: String?
    let weight: Float?
    let image: UIImage?
    let ingredients: [Ingredient]?
    
    var calories: Float? {
        return ingredients?
            .compactMap { $0.calories }
            .reduce(Float(0), +)
    }
    
    var fat: Float? {
        return ingredients?
            .compactMap { $0.fat }
            .reduce(Float(0), +)
    }
    
    var protein: Float? {
        return ingredients?
            .compactMap { $0.protein }
            .reduce(Float(0), +)
    }
    
    var carbs: Float? {
        return ingredients?
            .compactMap { $0.carbs }
            .reduce(Float(0), +)
    }
}
