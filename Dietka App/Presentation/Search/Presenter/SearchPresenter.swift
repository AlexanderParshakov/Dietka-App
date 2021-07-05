//
//  SearchPresenter.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/14/20.
//

protocol SearchViewProtocol: AnyObject {
    func setSearchType(to type: SearchType)
    func showProductSearchResult(productContents: [ProductElement])
    func showDietSearchResult(diets: [Diet])
    func showDishSearchResult(dishes: [Dish])
}

protocol SearchPresenterProtocol: AnyObject {
    init(view: SearchViewProtocol, router: SearchRouterProtocol)
    func startSearch(input: String?, searchType: SearchType)
    func tapOnProduct(product: ProductElement)
    func tapOnDish(dishInfo: Dish)
    func tapOnDiet(diet: Diet)
}

final class SearchPresenter: SearchPresenterProtocol {
    weak var view: SearchViewProtocol?
    var router: SearchRouterProtocol?
    
    init(view: SearchViewProtocol, router: SearchRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func tapOnProduct(product: ProductElement) {
        router?.showProductDetails(product: product)
    }
    
    func tapOnDish(dishInfo: Dish) {
        router?.showDishDetails(dishInfo: dishInfo)
    }
    
    func tapOnDiet(diet: Diet) {
        router?.showDietDetails(diet: diet)
    }
    
    func startSearch(input: String?, searchType: SearchType) {
        guard let input = input else { return }
        let networkManager = NetworkManager()
        
        switch searchType {
        case .products:
            networkManager.findProducts(matching: input) { [weak self] (productElements, error) in
                guard let productElements = productElements else { return }
                guard error == nil else { return }
                
                self?.view?.showProductSearchResult(productContents: productElements)
            }
        case .dishes:
            self.view?.showDishSearchResult(dishes: MockService.fetchDishes())
        case .diets:
            networkManager.findDiets(forInput: input) { [weak self] (diets, error) in
                guard let diets = diets else { return }
                guard error == nil else { return }
                
                self?.view?.showDietSearchResult(diets: diets)
            }
        }
        
    }
}
