//
//  ExploreSearchButton.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/13/20.
//

import UIKit

typealias Command = () -> Void

final class ExploreSearchButton: UIButton {
    
    private let command: Command
    private let customImageInsets = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 0)
    private let customTitleInsets = UIEdgeInsets(top: 0, left: -65, bottom: 0, right: 0)
    
    init(command: @escaping Command) {
        self.command = command
        super.init(frame: CGRect(x: 0, y: 0, width: 122, height: 46))
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.titleLabel?.font = .boldSystemFont(ofSize: 16)
        self.setTitle("Search", for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.setImage(#imageLiteral(resourceName: "Search"), for: .normal)
        self.imageEdgeInsets = self.customImageInsets
        self.titleEdgeInsets = self.customTitleInsets
        
        self.setMediumShadow()
        
        self.addTarget(self, action: #selector(onTapped), for: .touchUpInside)
        self.addTarget(self, action: #selector(onTouchedDown), for: [.touchDown])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onTapped() {
        self.showAnimatedPress { [weak self] in
            self?.command()
        }
    }
    
    @objc private func onTouchedDown() {
        self.showAnimatedPress()
    }
}
