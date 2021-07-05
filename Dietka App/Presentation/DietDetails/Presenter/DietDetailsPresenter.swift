//
//  DietDetailsPresenter.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/17/20.
//

import Foundation

protocol DietDetailsViewProtocol: AnyObject {
    
}

protocol DietDetailsPresenterProtocol: AnyObject {
    init(view: DietDetailsViewProtocol, router: SearchRouterProtocol, diet: Diet)
    var diet: Diet { get }
    
    func backArrowPressed()
}

final class DietDetailsPresenter: DietDetailsPresenterProtocol {
    weak var view: DietDetailsViewProtocol?
    var router: SearchRouterProtocol?
    
    let diet: Diet
    
    init(view: DietDetailsViewProtocol, router: SearchRouterProtocol, diet: Diet) {
        self.view = view
        self.router = router
        self.diet = diet
    }
    
    func backArrowPressed() {
        router?.pop()
    }
}
