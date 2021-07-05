//
//  ExplorePresenter.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/12/20.
//

protocol ExploreViewProtocol: AnyObject {
    func showDiets(diets: [Diet]?)
    func showDishes(dishes: [Dish]?)
}

protocol ExplorePresenterProtocol: AnyObject {
    init(view: ExploreViewProtocol, router: ExploreRouterProtocol, diets: [Diet]?, dishes: [Dish]?)
    var diets: [Diet]? { get }
    var dishes: [Dish]? { get }
    func loadDiets()
    func tapOnSearch()
}

final class ExplorePresenter: ExplorePresenterProtocol {
    weak var view: ExploreViewProtocol?
    var router: ExploreRouterProtocol?
    let diets: [Diet]?
    let dishes: [Dish]?
    
    init(view: ExploreViewProtocol, router: ExploreRouterProtocol, diets: [Diet]?, dishes: [Dish]?) {
        self.view = view
        self.router = router
        self.diets = diets
        self.dishes = dishes
    }
    
    func showDiets() {
        
    }
    
    func showDishes() {
        
    }
    
    func loadDiets() {
        let networkManager = NetworkManager()
        networkManager.findDiets(forInput: "") { [weak self] (diets, error) in
            guard let self = self else { return }
            guard let diets = diets else { return }
            guard error == nil else { return }
            
            self.view?.showDiets(diets: diets)
        }
    }
    
    func tapOnSearch() {
        router?.showSearch()
    }
}
