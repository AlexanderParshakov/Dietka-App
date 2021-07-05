//
//  DietDetailsViewController.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 12/17/20.
//

import UIKit

final class DietDetailsViewController: ScrollableViewController {
    var presenter: DietDetailsPresenterProtocol!
    
    private let previewHeight: CGFloat = 300
    
    private var thumbnailImage: UIImageView!
    private var titleWrapperView: UIView!
    private var descriptionView: DietDescriptionView!
    private var daysStackView: UIStackView!
    private var followButton: UIButton!
    
    private var isFollowing: Bool = false {
        didSet {
            let title = isFollowing ? "Unfollow" : "Follow"
            followButton.setTitle(title, for: .normal)
//            setupDaysStackView()
            updateDaysStackView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentInset = UIEdgeInsets(top: previewHeight, left: 0, bottom: 0, right: 0)
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 2000)
        scrollView.setContentOffset(CGPoint(x: 0, y: -previewHeight), animated: false)
        scrollView.delegate = self
        
        view.backgroundColor = .white
        
        setupThumbnailImage()
        setupTitleWrapperView()
        setupDescriptionView()
        setupDaysStackView()
        setupFollowButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.tintColor = .button
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        followButton.snp.remakeConstraints { (remake) in
            remake.width.equalTo(view.frame.width * 0.8)
            remake.height.equalTo(50)
            remake.centerX.equalTo(view.snp.centerX)
            remake.bottom.equalTo(view.snp.bottom).inset(50)
        }
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupThumbnailImage() {
        thumbnailImage = UIImageView()
        
        if let urlString = presenter.diet.preview,
           let url = URL(string: urlString),
           let data = try? Data(contentsOf: url) {
            thumbnailImage.image = UIImage(data: data)
        }
        
        thumbnailImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: previewHeight)
        thumbnailImage.contentMode = .scaleAspectFill
        thumbnailImage.clipsToBounds = true
        
        view.addSubview(thumbnailImage)
    }
    
    private func setupTitleWrapperView() {
        titleWrapperView = UIView()
        
        titleWrapperView.frame = CGRect(x: 0, y: 200, width: UIScreen.main.bounds.size.width, height: 40)
        titleWrapperView.clipsToBounds = true
        titleWrapperView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        titleWrapperView.layer.cornerRadius = titleWrapperView.frame.height / 2
        titleWrapperView.isUserInteractionEnabled = false
        
        let label = UILabel()
        
        label.text = presenter.diet.dietName
        label.font = .semiboldTitleFont
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        
        view.addSubview(titleWrapperView)
        titleWrapperView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.leading.equalTo(thumbnailImage.snp.leading).offset(100)
            make.trailing.equalTo(thumbnailImage.snp.trailing).inset(100)
            make.top.equalTo(view.snp.top).offset(45)
        }
        
        titleWrapperView.addSubview(label)
        label.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(titleWrapperView)
            make.leading.equalTo(titleWrapperView.snp.leading).offset(10)
            make.trailing.equalTo(titleWrapperView.snp.trailing).inset(10)
        }
    }
    
    private func setupTitleLabel() {
        let label = UILabel()
        
        label.text = presenter.diet.dietName
        label.font = .semiboldTitleFont
        label.textAlignment = .center
        label.textColor = .white
    }
    
    private func setupDescriptionView() {
        guard let description = presenter.diet.dietDescription else { return }
        descriptionView = DietDescriptionView.make(body: description)
        
        scrollView.addSubview(descriptionView)
        
        descriptionView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(30)
            make.trailing.equalTo(view.snp.trailing).inset(30)
        }
    }
    
    private func setupDaysStackView() {
        daysStackView = UIStackView()
        guard let dietPlans = presenter.diet.dietPlans else { return }
        daysStackView.axis = .vertical
        daysStackView.alignment = .center
        daysStackView.distribution = .equalSpacing
        daysStackView.spacing = 25
        daysStackView.backgroundColor = .white
        
        let days: Array<Int> = dietPlans.compactMap{ $0.dayNumber }
        let distinctDays = Set.init(days).sorted(by: <)
        distinctDays.forEach { (dayNumber) in
            let dayDietPlans = presenter.diet.dietPlans?.filter{ $0.dayNumber == dayNumber } ?? []
            let dayView = DayView.make(dietPlans: dayDietPlans, areSwitchesHidden: !isFollowing)
            
            daysStackView.addArrangedSubview(dayView)
        }
        
        scrollView.addSubview(daysStackView)
        daysStackView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionView.snp.bottom).offset(20)
//            make.bottom.equalTo(scrollView.snp.bottom).inset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).inset(20)
        }
        view.layoutIfNeeded()
        let newHeight = descriptionView.bounds.height + daysStackView.bounds.height
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: newHeight + 100)
    }
    
    private func updateDaysStackView() {
//        daysStackView.arrangedSubviews.forEach { (view) in
//            if view is DayView {
//                (view as! DayView).
//            }
//        }
    }
    
    private func setupFollowButton() {
        followButton = UIButton()
        followButton.backgroundColor = .button
        followButton.setTitle("Follow", for: .normal)
        followButton.titleLabel?.font = .boldPrimaryFont
        followButton.setTitleColor(.white, for: .normal)
        followButton.layer.cornerRadius = 10
        followButton.setSlightShadow()
        followButton.addTarget(self, action: #selector(onFollowTapped), for: .touchUpInside)
        
        view.addSubview(followButton)
        followButton.snp.makeConstraints { (make) in
            make.width.equalTo(view.frame.width * 0.8)
            make.height.equalTo(50)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(100)
        }
    }
    
    @objc private func onFollowTapped() {
        isFollowing = !isFollowing
    }
}

extension DietDetailsViewController: DietDetailsViewProtocol {
    
}

extension DietDetailsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yForImage = previewHeight - (scrollView.contentOffset.y + previewHeight)
        let heightForImage = min(max(yForImage, 0), 550)
        thumbnailImage.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: heightForImage)
        
        if heightForImage < 50 {
            navigationController?.navigationBar.tintColor = .button
        } else {
            navigationController?.navigationBar.tintColor = .white
        }
    }
}
