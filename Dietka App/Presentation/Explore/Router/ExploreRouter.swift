//
//  ExploreRouter.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/14/20.
//

import UIKit

protocol ExploreRouterProtocol: BaseRouter {
    func initialViewController()
    func showSearch()
    func showDietDetails()
    func showDishDetails()
}

final class ExploreRouter: ExploreRouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = self.navigationController {
            guard let mainViewController = assemblyBuilder?.buildExploreModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
            navigationController.tabBarItem.image = #imageLiteral(resourceName: "Explore")
        }
    }
    
    func showSearch() {
        if let navigationController = self.navigationController,
           let assemblyBuilder = self.assemblyBuilder {
            let router = SearchRouter(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
            let searchViewController = assemblyBuilder.buildSearchModule(router: router)
            navigationController.pushViewController(searchViewController, animated: true)
        }
    }
    
    func showDietDetails() {
        
    }
    
    func showDishDetails() {
        
    }
}
