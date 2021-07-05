//
//  ExploreAndSearchView.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/13/20.
//

import UIKit

final class ExploreAndSearchView: UIView {
    
    private(set) var titleLabel: ExploreTitleLabel!
    private let searchButton: ExploreSearchButton!
    private let separator: Separator!
    
    init(searchCommand: @escaping Command) {
        self.searchButton = ExploreSearchButton(command: searchCommand)
        self.separator = Separator(color: .secondarySeparator)
        self.titleLabel = ExploreTitleLabel()
        
        super.init(frame: CGRect())
        
        self.backgroundColor = .none
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(searchButton)
        addSubview(separator)
        
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(30)
            make.centerY.equalTo(self.snp.centerY)
        }
        searchButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.snp.trailing).inset(30)
            make.height.equalTo(46)
            make.width.equalTo(122)
            make.centerY.equalTo(self.snp.centerY)
        }
        separator.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(25)
            make.trailing.equalTo(self.snp.trailing).inset(25)
            make.top.equalTo(searchButton.snp.bottom).offset(20)
            make.bottom.equalTo(self.snp.bottom)
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(2)
        }
    }
}
