//
//  ProductDetailsViewController.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/16/20.
//

import Foundation

protocol ProductDetailsViewProtocol: AnyObject {
    
}

protocol ProductDetailsPresenterProtocol: AnyObject {
    init(view: ProductDetailsViewProtocol, router: SearchRouterProtocol, product: ProductElement)
    var product: ProductElement { get }
    
    func backArrowPressed()
}

final class ProductDetailsPresenter: ProductDetailsPresenterProtocol {
    weak var view: ProductDetailsViewProtocol?
    var router: SearchRouterProtocol?
    
    let product: ProductElement
    
    init(view: ProductDetailsViewProtocol, router: SearchRouterProtocol, product: ProductElement) {
        self.view = view
        self.router = router
        self.product = product
    }
    
    func backArrowPressed() {
        router?.pop()
    }
}
