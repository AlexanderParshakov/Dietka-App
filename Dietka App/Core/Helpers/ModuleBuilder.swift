//
//  ModuleBuilder.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/13/20.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func buildExploreModule(router: ExploreRouterProtocol) -> UIViewController
    func buildSearchModule(router: SearchRouterProtocol) -> UIViewController
    func buildProductDetailsModule(router: SearchRouterProtocol, product: ProductElement) -> UIViewController
    func buildDishDetailsModule(router: SearchRouterProtocol, dishInfo: Dish) -> UIViewController
    func buildDietDetailsModule(router: SearchRouterProtocol, diet: Diet) -> UIViewController
}

final class ModuleBuilder: AssemblyBuilderProtocol {
    func buildExploreModule(router: ExploreRouterProtocol) -> UIViewController {
        let view = ExploreViewController()
        let presenter = ExplorePresenter(view: view, router: router, diets: nil, dishes: nil)
        view.presenter = presenter
        
        return view
    }
    
    func buildSearchModule(router: SearchRouterProtocol) -> UIViewController {
        let view = SearchViewController()
        let presenter = SearchPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func buildProductDetailsModule(router: SearchRouterProtocol, product: ProductElement) -> UIViewController {
        let view = ProductDetailsViewController()
        let presenter = ProductDetailsPresenter (view: view, router: router, product: product)
        view.presenter = presenter
        return view
    }
    
    func buildDishDetailsModule(router: SearchRouterProtocol, dishInfo: Dish) -> UIViewController {
        let view = DishDetailsViewController()
        let presenter = DishDetailsPresenter(view: view, router: router, dishInfo: dishInfo)
        view.presenter = presenter
        return view
    }
    
    func buildDietDetailsModule(router: SearchRouterProtocol, diet: Diet) -> UIViewController {
        let view = DietDetailsViewController()
        let presenter = DietDetailsPresenter(view: view, router: router, diet: diet)
        view.presenter = presenter
        return view
    }
}
