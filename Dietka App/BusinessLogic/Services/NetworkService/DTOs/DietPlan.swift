//
//  DietPlan.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/16/20.
//

import Foundation

struct Diet: Codable {
    let dietID: Int?
    let dietName, dietDescription, preview: String?
    let dietPlans: [DietPlan]?

    enum CodingKeys: String, CodingKey {
        case dietID = "dietId"
        case dietPlans = "dietPlan"
        case dietName, dietDescription, preview
    }
}

// MARK: - DietPlan
struct DietPlan: Codable {
    let dayNumber: Int?
    let meal: DietMeal?
    let dish: DietDish?
}

// MARK: - Dish
struct DietDish: Codable {
    let dishID: Int?
    let dishName: String?
    let dishDescription: String?
    let ingredientsList: String?
    let directions: String?
    let kcal, protein, fat, carbs: Int?
    let picsURL: String?

    enum CodingKeys: String, CodingKey {
        case dishID = "dishId"
        case dishName, dishDescription, ingredientsList, directions, kcal, protein, fat, carbs
        case picsURL = "picsUrl"
    }
}

enum DietMeal: String, Codable {
    case breakfast = "Breakfast"
    case dinner = "Dinner"
    case lunch = "Lunch"
    case snack = "Snack"
}
