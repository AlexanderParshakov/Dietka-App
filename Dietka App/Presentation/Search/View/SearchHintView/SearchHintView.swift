//
//  SearchHintView.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/3/20.
//

import UIKit

final class SearchHintView: UIView {
    
    private var hintState: SearchHintState
    
    private let imageView: UIImageView = UIImageView()
    private let hintLabel: UILabel = UILabel()
    
    init(hintState: SearchHintState) {
        self.hintState = hintState
        
        super.init(frame: CGRect())
        
        setupImageView()
        
        updateState(hintState: hintState)
        setupHintLabel()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.image = UIImage.init(named: "AppSymbol")
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.centerX.equalTo(self.snp.centerX)
//            make.leading.greaterThanOrEqualTo(self.snp.leading).offset(20)
//            make.trailing.greaterThanOrEqualTo(self.snp.trailing).inset(40)
            make.width.equalTo(200)
            make.height.equalTo(imageView.snp.width)
        }
    }
    
    private func setupHintLabel() {
        addSubview(hintLabel)
        
        hintLabel.setLineSpacing(lineSpacing: 5, lineHeightMultiple: 1)
        hintLabel.textAlignment = .center
        hintLabel.numberOfLines = 0
        hintLabel.font = .boldPrimaryFont
        hintLabel.textColor = .button
        hintLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(10)
            make.bottom.equalTo(self.snp.bottom).offset(0)
        }
    }
    
    public func updateState(hintState: SearchHintState, searchType: SearchType? = nil) {
        switch hintState {
        case .searchSuggestion:
            toggleVisibility(isHidden: false)
            hintLabel.text = "Choose a category, type your thing, \n" +
                "and let’s find something for you!"
        case .searchInProgress:
            toggleVisibility(isHidden: false)
            guard let searchType = searchType?.rawValue.lowercasingFirstLetter() else { return }
            hintLabel.text = "Searching among \(searchType)..."
        case .foundResults:
            toggleVisibility(isHidden: true)
        case .nothingFound:
            toggleVisibility(isHidden: false)
            hintLabel.text = "Unfortunately, nothing has been found for the input you provided."
        }
    }
    
    private func toggleVisibility(isHidden: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.isHidden = isHidden
            self?.imageView.isHidden = isHidden
            self?.hintLabel.isHidden = isHidden
        }
    }
}

enum SearchHintState {
    case searchSuggestion
    case searchInProgress
    case foundResults
    case nothingFound
}
