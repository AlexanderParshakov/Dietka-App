//
//  IngredientListView.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/7/20.
//

import UIKit

final class IngredientListView: UIView, NibLoadable {
    @IBOutlet weak var ingredientsStackView: UIStackView!
    
    private var backButtonAction: (() -> Void?)? = nil
    
    @IBAction func onBackButtonTapped(_ sender: Any) {
        guard let backButtonAction = backButtonAction else { return }
        backButtonAction()
    }
    
    static func make(ingredients: [Ingredient]?, backButtonAction: @escaping () -> Void?) -> IngredientListView {
        let ingredientListView = IngredientListView.loadFromNib()
        ingredientListView.backButtonAction = backButtonAction
        guard let ingredients = ingredients else { return ingredientListView }
        
        ingredients.forEach {
            let ingredientView = ProductPreview.make(ingredient: $0)
            ingredientListView.ingredientsStackView.addArrangedSubview(ingredientView)
        }
        
        
        return ingredientListView
    }
}
