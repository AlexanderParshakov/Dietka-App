//
//  SearchRouter.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/14/20.
//

import UIKit

protocol SearchRouterProtocol: BaseRouter {
    func showDishDetails(dishInfo: Dish)
    func showProductDetails(product: ProductElement)
    func showDietDetails(diet: Diet)
}

final class SearchRouter: SearchRouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func showDishDetails(dishInfo: Dish) {
        if let navigationController = navigationController {
            guard let dishDetailsViewController = assemblyBuilder?.buildDishDetailsModule(router: self, dishInfo: dishInfo) else { return }
            navigationController.pushViewController(dishDetailsViewController, animated: true)
        }
    }
    
    func showProductDetails(product: ProductElement) {
        guard let navigationController = navigationController else { return }
        guard let productDetailsViewController = assemblyBuilder?.buildProductDetailsModule(router: self, product: product) else { return }
        navigationController.pushViewController(productDetailsViewController, animated: true)
    }
    
    func showDietDetails(diet: Diet) {
        guard let navigationController = navigationController else { return }
        guard let dietDetailsViewController = assemblyBuilder?.buildDietDetailsModule(router: self, diet: diet) else { return }
        navigationController.pushViewController(dietDetailsViewController, animated: true)
    }
}
