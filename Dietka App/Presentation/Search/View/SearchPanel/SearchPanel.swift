//
//  SearchPanel.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/14/20.
//

import UIKit

final class SearchPanel: UIStackView {
    
    let searchTextFieldPanel = SearchTextFieldPanel()
    private let searchTypePanel = SearchTypePanel(searchType: .products)
    
    var searchType: SearchType { searchTypePanel.currentType }
    
    init() {
        super.init(frame: CGRect())
        
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.axis = .vertical
        self.spacing = 30
        self.distribution = .fillEqually
        
        self.addArrangedSubview(searchTextFieldPanel)
        self.addArrangedSubview(searchTypePanel)
        
        searchTypePanel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-10)
        }
    }
    
    func toggleActive(isActive: Bool) {
        if isActive {
            searchTextFieldPanel.becomeActive()
        } else {
            searchTextFieldPanel.endEditing(true)
        }
    }
    
    func setSearchType(searchType: SearchType) {
        searchTypePanel.setSearchType(searchType: searchType)
    }
}
