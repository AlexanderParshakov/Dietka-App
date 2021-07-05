//
//  SearchTextFieldPanel.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/14/20.
//

import UIKit

protocol SearchTextFieldPanelDelegate: AnyObject {
    func triggerSearch(input: String?)
    func stopSearch()
}

final class SearchTextFieldPanel: UIView {
    
    private let textField = SearchTextField()
    private let separator = Separator(color: .searchPlaceholder)
    
    weak var delegate: SearchTextFieldPanelDelegate?
    
    init() {
        super.init(frame: CGRect())
        
        textField.delegate = self
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(textField)
        addSubview(separator)
        
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(10)
            make.height.equalTo(50)
        }
        updateSeparator(isActive: false)
    }
    
    private func updateSeparator(isActive: Bool) {
        separator.snp.remakeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(isActive ? 2.8 : 2)
        }
    }
    
    func becomeActive() {
        textField.becomeFirstResponder()
    }
}

extension SearchTextFieldPanel: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateColor(isActive: false)
        delegate?.stopSearch()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        animateColor(isActive: true)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.triggerSearch(input: textField.text)
        return true
    }
    
    private func animateColor(isActive: Bool) {
        self.updateSeparator(isActive: isActive)
        UIView.animate(withDuration: 0.3) {
            self.separator.backgroundColor = isActive ? .light : .searchPlaceholder
            self.layoutIfNeeded()
        }
    }
}
