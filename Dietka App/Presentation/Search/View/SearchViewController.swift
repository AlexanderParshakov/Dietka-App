//
//  SearchViewController.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/14/20.
//

import UIKit

final class SearchViewController: InteractiveViewController {
    var presenter: SearchPresenterProtocol!
    
    private let searchPanel = SearchPanel()
    private let searchHintView = SearchHintView(hintState: .searchSuggestion)
    private let tableView = UITableView()
    
    private var products: [ProductElement]? {
        didSet {
            updateView(withOptionalArray: products)
        }
    }
    private var dishes: [Dish]? {
        didSet {
            updateView(withOptionalArray: dishes)
        }
    }
    private var diets: [Diet]? {
        didSet {
            updateView(withOptionalArray: diets)
        }
    }
    
    private var hasFocusedSearchOnce = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Search"
        self.view.backgroundColor = .white
        self.navigationController?.becomeTransparent()
        tabBarController?.tabBar.isHidden = true
        
        setupSearchPanel()
        setupTableView()
        setupHintView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !hasFocusedSearchOnce {
            searchPanel.toggleActive(isActive: true)
            hasFocusedSearchOnce = true
        }
    }
    
    private func setupSearchPanel() {
        view.addSubview(searchPanel)
        
        searchPanel.searchTextFieldPanel.delegate = self
        
        searchPanel.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                make.top.equalTo(self.view.snp.top)
            }
            make.leading.equalTo(self.view.snp.leadingMargin)
            make.trailing.equalTo(self.view.snp.trailingMargin)
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(ProductPreviewCell.self, forCellReuseIdentifier: String(describing: ProductPreviewCell.self))
        tableView.register(DishPreviewCell.self, forCellReuseIdentifier: String(describing: DishPreviewCell.self))
        tableView.register(DietPreviewCell.self, forCellReuseIdentifier: String(describing: DietPreviewCell.self))
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchPanel.snp.bottom).offset(20)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
        
        tableView.isHidden = true
    }
    
    private func setupHintView() {
        view.addSubview(searchHintView)
        searchHintView.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width).multipliedBy(0.85)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(searchPanel.snp.bottom).offset(50)
        }
    }
    
    private func updateView(withOptionalArray optionalArray: Array<Any>?) {
        if optionalArray == nil {
            self.tableView.isHidden = true
            searchHintView.updateState(hintState: .searchSuggestion)
            return
        } else if (optionalArray?.count == 0) {
            searchHintView.updateState(hintState: .nothingFound)
            return
        }
        
        DispatchQueue.main.async {
            self.searchHintView.updateState(hintState: .foundResults)
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchPanel.searchType {
        case .products:
            return products?.count ?? 0
        case .dishes:
            return dishes?.count ?? 0
        case .diets:
            return diets?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch searchPanel.searchType {
        case .products:
            guard let productContents = products else { return UITableViewCell() }
            guard let productInfoCell = tableView.productCell() else { return UITableViewCell() }
            let productInfo = productContents[indexPath.row]
            productInfoCell.set(withProductInfo: productInfo)
            return productInfoCell
        case .dishes:
            guard let dishContents = dishes else { return UITableViewCell() }
            guard let dishInfoCell = tableView.dishCell() else { return UITableViewCell() }
            let dishInfo = dishContents[indexPath.row]
            dishInfoCell.set(withDishInfo: dishInfo)
            return dishInfoCell
        case .diets:
            guard let diets = diets else { return UITableViewCell() }
            guard let dietPreviewCell = tableView.dietCell() else { return UITableViewCell() }
            let diet = diets[indexPath.row]
            dietPreviewCell.set(withDiet: diet)
            return dietPreviewCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch searchPanel.searchType {
        case .products:
            guard let products = products else { break }
            let product = products[indexPath.row]
            presenter.tapOnProduct(product: product)
        case .dishes:
            guard let dishes = dishes else { break }
            let dishInfo = dishes[indexPath.row]
            presenter.tapOnDish(dishInfo: dishInfo)
        case .diets:
            guard let diets = diets else { break }
            let diet = diets[indexPath.row]
            presenter.tapOnDiet(diet: diet)
        }
        
    }
}

extension SearchViewController: SearchViewProtocol {
    func setSearchType(to type: SearchType) {
        searchPanel.setSearchType(searchType: type)
    }
    
    func showProductSearchResult(productContents: [ProductElement]) {
        self.products = productContents
    }
    
    func showDishSearchResult(dishes: [Dish]) {
        self.dishes = dishes
    }
    
    func showDietSearchResult(diets: [Diet]) {
        self.diets = diets
    }
}

extension SearchViewController: SearchTextFieldPanelDelegate {
    func triggerSearch(input: String?) {
        presenter.startSearch(input: input, searchType: searchPanel.searchType)
        searchPanel.toggleActive(isActive: false)
        searchHintView.updateState(hintState: .searchInProgress, searchType: searchPanel.searchType)
        tableView.isHidden = true
    }
    
    func stopSearch() {
        guard products == nil, dishes == nil else { return }
        searchHintView.updateState(hintState: .searchSuggestion)
    }
}

private extension UITableView {
    func productCell() -> ProductPreviewCell? {
        let cell = self.dequeueReusableCell(withIdentifier: String(describing: ProductPreviewCell.self))
        cell?.selectionStyle = .none
        return cell as? ProductPreviewCell
    }
    
    func dishCell() -> DishPreviewCell? {
        let cell = self.dequeueReusableCell(withIdentifier: String(describing: DishPreviewCell.self))
        cell?.selectionStyle = .none
        return cell as? DishPreviewCell
    }
    
    func dietCell() -> DietPreviewCell? {
        let cell = self.dequeueReusableCell(withIdentifier: String(describing: DietPreviewCell.self))
        cell?.selectionStyle = .none
        return cell as? DietPreviewCell
    }
}

extension SearchViewController: TabBarSupport {
    var isTabBarHidden: Bool {
        return true
    }
}
