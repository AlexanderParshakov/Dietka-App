//
//  ExploreViewController.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/1/20.
//

import UIKit

final class ExploreViewController: ScrollableViewController {
    
    var presenter: ExplorePresenterProtocol!
    private var exploreAndSearchView: ExploreAndSearchView!
    private var dietsCollectionView: UICollectionView!
    private var dishesCollectionView: UICollectionView!
    
    private var diets: [Diet]? {
        didSet {
            updateCollectionView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Explore"
        navigationItem.titleView = UIView()
        
        setCircleBackground()
        setupExploreAndSearchView()
        setupDietsCollectionView()
        
//        presenter.loadDiets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setupExploreAndSearchView() {
        self.exploreAndSearchView = ExploreAndSearchView(searchCommand: { [weak self] in
            self?.presenter.tapOnSearch()
        })
        scrollView.addSubview(exploreAndSearchView)
        exploreAndSearchView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(50)
            make.width.equalTo(view.snp.width)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    private func setupDietsCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        dietsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        dietsCollectionView.backgroundColor = .clear
        dietsCollectionView.register(DietPreviewCollectionCell.self, forCellWithReuseIdentifier: String(describing: DietPreviewCollectionCell.self))
        
        dietsCollectionView.delegate = self
        dietsCollectionView.dataSource = self
        
        scrollView.addSubview(dietsCollectionView)
        dietsCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top).offset(350)
//            make.bottom.equalTo(view.snp.bottom).offset(50)
            make.leading.equalTo(scrollView.snp.leading).offset(30)
            make.trailing.equalTo(scrollView.snp.trailing).offset(30)
            make.height.equalTo(400)
        }
        view.layoutIfNeeded()
//        dietsCollectionView.alpha = 0
    }
    
    private func updateCollectionView() {
        DispatchQueue.main.async {
            self.dietsCollectionView.reloadData()
            if self.diets?.count ?? 0 > 0 {
                UIView.animate(withDuration: 0.3) {
                    self.dietsCollectionView.alpha = 1
                }
            }
        }
    }
}

extension ExploreViewController: ExploreViewProtocol {
    func showDiets(diets: [Diet]?) {
        self.diets = diets
    }
    
    func showDishes(dishes: [Dish]?) {
        
    }
}

extension ExploreViewController: CircleBackgroundable {
    var circleBackgroundType: CircleBackgroundType { .explore }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dietsCollectionView {
            return diets?.count ?? 0
        } else {
            return presenter.dishes?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dietsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DietPreviewCollectionCell.self), for: indexPath) as? DietPreviewCollectionCell else { return UICollectionViewCell() }
            guard let diets = self.diets else { return UICollectionViewCell() }
            let diet = diets[indexPath.row]
            cell.set(withDiet: diet)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: 400, height: 300)
    }
}
