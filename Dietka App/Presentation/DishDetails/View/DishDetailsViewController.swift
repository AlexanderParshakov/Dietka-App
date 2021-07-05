//
//  DishDetailsViewController.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/6/20.
//

import UIKit

final class DishDetailsViewController: ScrollableViewController {
    var presenter: DishDetailsPresenterProtocol!
    
    private var dishMainInfoView: DishMainInfoView!
    private var ingredientListView: IngredientListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setCircleBackground()
        
        self.view.backgroundColor = .white
        self.navigationController?.becomeTransparent()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        setupMainInfoView()
        setupIngredientList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        dishMainInfoView.fadeCircle(isHidden: false)
        UIView.animate(withDuration: 0.4) {
            self.dishMainInfoView.alpha = 1
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 0.1) {
            self.dishMainInfoView.alpha = 0
        }
    }
    
    private func setupMainInfoView() {
        dishMainInfoView = DishMainInfoView.make(dishInfo: presenter.dishInfo)
        view.addSubview(dishMainInfoView)
        
        dishMainInfoView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(-90)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
    }
    
    private func setupIngredientList() {
        let backButtonAction = { [weak self] in
            self?.presenter.backArrowPressed()
        }
        ingredientListView = IngredientListView.make(ingredients: presenter.dishInfo.ingredients, backButtonAction: backButtonAction)
        scrollView.addSubview(ingredientListView)
        view.layoutIfNeeded()
        
        ingredientListView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top).offset(dishMainInfoView.bounds.height / 1.5)
            make.leading.equalTo(scrollView.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).inset(20)
            make.bottom.equalTo(scrollView.snp.bottom).inset(30)
        }
        
        ingredientListView.setSlightShadow()
        ingredientListView.layer.cornerRadius = 10
        view.sendSubviewToBack(dishMainInfoView)
        view.bringSubviewToFront(ingredientListView)
        view.layoutIfNeeded()
    }
}

extension DishDetailsViewController: DishDetailsViewProtocol {
    
}

extension DishDetailsViewController: CircleBackgroundable {
    var circleBackgroundType: CircleBackgroundType {
        return .dishInfo
   }
}
