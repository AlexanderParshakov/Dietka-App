//
//  DishDetailsRouter.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/6/20.
//

import UIKit

protocol DishDetailsRouterProtocol: BaseRouter {
    func initialViewController()
}

final class DishDetailsRouter: DishDetailsRouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
//        if let navigationController = self.navigationController {
//            guard let mainViewController = assemblyBuilder?.buildDishDetailsModule(router: self) else { return }
//            navigationController.viewControllers = [mainViewController]
//        }
    }
    
    func popToRoot() {
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}



