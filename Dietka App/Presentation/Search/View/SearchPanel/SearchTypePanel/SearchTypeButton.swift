//
//  SearchTypeButton.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/14/20.
//

import UIKit

final class SearchTypeButton: SolidButton {
    private let command: Command?
    
    init(title: String, isActive: Bool, command: @escaping Command) {
        self.command = command
        super.init(frame: CGRect())
        
        self.backgroundColor = .white
        self.setTitle(title, for: .normal)
        self.updateState(isActive: isActive)
        
        self.addTarget(self, action: #selector(fireCommand), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setSlightShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateState(isActive: Bool) {
        if isActive {
            self.showAnimatedPress { [weak self] in
                UIView.animate(withDuration: 0.2) {
                    self?.setTitleColor(.button, for: .normal)
                    self?.titleLabel?.font = .boldPrimaryFont
                }
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.setTitleColor(.black, for: .normal)
                self.titleLabel?.font = .mediumPrimaryFont
            }
        }
    }
    
    @objc private func fireCommand() {
        self.command?()
    }
}
