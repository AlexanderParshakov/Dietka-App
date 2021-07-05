//
//  ProductDetailsViewController.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/16/20.
//

import UIKit

final class ProductDetailsViewController: ScrollableViewController {
    var presenter: ProductDetailsPresenterProtocol!
    
    private var detailsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = presenter.product.foodDES?.longDesc
        
        setupDetailsStackView()
    }
    
    private func setupDetailsStackView() {
        detailsStackView = UIStackView()
        detailsStackView.distribution = .equalSpacing
        detailsStackView.axis = .vertical
        detailsStackView.spacing = 10
        
        presenter.product.nutrients?.forEach({ (nutrient) in
            let nutrientLabel = UILabel()
            nutrientLabel.font = .boldPrimaryFont
            nutrientLabel.textColor = .black
            guard let name = nutrient.nutrientName,
                  let value = nutrient.nutrientValue else { return }
            nutrientLabel.text = "\(name): \(value)"
            
            detailsStackView.addArrangedSubview(nutrientLabel)
        })
        
        scrollView.addSubview(detailsStackView)
        detailsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.leading.equalTo(scrollView.snp.leading).offset(20)
            make.trailing.equalTo(scrollView.snp.trailing).inset(20)
        }
    }
}

extension ProductDetailsViewController: ProductDetailsViewProtocol {
    
}
