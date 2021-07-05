//
//  MockService.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/6/20.
//

struct MockService {
    private init() {}
    
    static func fetchDishes() -> [Dish] {
        return [
            Dish(title: "Spaghetti Bolognese",
                 weight: 300,
                 image: #imageLiteral(resourceName: "DishExample"), ingredients: [
                    Ingredient(calories: 456,
                               protein: 27,
                               fat: 31,
                               carbs: 59),
                    Ingredient(calories: 456,
                               protein: 27,
                               fat: 31,
                               carbs: 59),
                    Ingredient(calories: 456,
                               protein: 27,
                               fat: 31,
                               carbs: 59),
                    Ingredient(calories: 456,
                               protein: 27,
                               fat: 31,
                               carbs: 59)]),
            Dish(title: "Pulled Pork Tacos",
                 weight: 350,
                 image: #imageLiteral(resourceName: "Pulled Pork Tacos"), ingredients: [
                    Ingredient(calories: 456,
                               protein: 27,
                               fat: 31,
                               carbs: 59),
                    Ingredient(calories: 456,
                               protein: 27,
                               fat: 31,
                               carbs: 59),
                    Ingredient(calories: 456,
                               protein: 27,
                               fat: 31,
                               carbs: 59),
                    Ingredient(calories: 456,
                               protein: 27,
                               fat: 31,
                               carbs: 59),
                    Ingredient(calories: 456,
                               protein: 27,
                               fat: 31,
                               carbs: 59)])
        ]
    }
}
