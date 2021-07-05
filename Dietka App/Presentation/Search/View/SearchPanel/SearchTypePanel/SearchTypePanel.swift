//
//  SearchTypePanel.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/14/20.
//

import UIKit

final class SearchTypePanel: UIStackView {
    
    private(set) var currentType: SearchType
    
    init(searchType: SearchType) {
        self.currentType = searchType
        super.init(frame: CGRect())
        
        self.distribution = .equalCentering
        
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtons() {
        SearchType.allCases.forEach { (searchType) in
            let isActive = self.currentType.rawValue == searchType.rawValue
            let typeButton = SearchTypeButton(title: searchType.rawValue, isActive: isActive) { [weak self] in
                self?.setSearchType(searchType: searchType)
            }
            typeButton.snp.makeConstraints { (make) in
                let screenWidth = UIScreen.main.bounds.width
                make.width.equalTo(screenWidth * 0.25)
                make.height.equalTo(36)
            }
            self.addArrangedSubview(typeButton)
        }
    }
    
    private func updateButtons() {
        self.arrangedSubviews.forEach { (view) in
            guard let button = view as? SearchTypeButton else { return }
            if button.currentTitle == self.currentType.rawValue {
                button.updateState(isActive: true)
            } else {
                button.updateState(isActive: false)
            }
        }
    }
    
    func setSearchType(searchType: SearchType) {
        self.currentType = searchType
        self.updateButtons()
    }
}
