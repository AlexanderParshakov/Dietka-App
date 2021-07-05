//
//  DishDetailsPresenter.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/6/20.
//

protocol DishDetailsViewProtocol: AnyObject {
    
}

protocol DishDetailsPresenterProtocol: AnyObject {
    init(view: DishDetailsViewProtocol, router: SearchRouterProtocol, dishInfo: Dish)
    var dishInfo: Dish { get }
    
    func backArrowPressed()
}

final class DishDetailsPresenter: DishDetailsPresenterProtocol {
    weak var view: DishDetailsViewProtocol?
    var router: SearchRouterProtocol?
    
    let dishInfo: Dish
    
    init(view: DishDetailsViewProtocol, router: SearchRouterProtocol, dishInfo: Dish) {
        self.view = view
        self.router = router
        self.dishInfo = dishInfo
    }
    
    func backArrowPressed() {
        router?.pop()
    }
}
