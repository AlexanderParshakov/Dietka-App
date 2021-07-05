//
//  CircleBackgroundable.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/14/20.
//

import SnapKit

protocol CircleBackgroundable: UIViewController {
    var circleBackgroundType: CircleBackgroundType { get }
    func setCircleBackground()
}

extension CircleBackgroundable {
    func setCircleBackground() {
        let circleBackground = CircleBackground(type: circleBackgroundType)
        view.addSubview(circleBackground)
        view.sendSubviewToBack(circleBackground)
        circleBackground.snp.makeConstraints { (make) in
            make.height.equalTo(view.snp.height)
            make.width.equalTo(view.snp.width)
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
    }
}
