import Foundation
import UIKit
import SnapKit

internal final class MainViewPresentable: BaseView {
    
    // MARK: Private Properties
    private lazy var adCollectionView: BaseUICollectionView = .init()
    private lazy var categoryCollectionView: CategoryCollectionView = .init()
    private lazy var searchBar: UISearchBar = .init()
    private lazy var addAdsButton: AddButton = .init()
    private lazy var myProfileButton: UIButton = .init()
    private lazy var refreshControl: UIRefreshControl = .init()
    private let mainShimmerView = MainShimmerView()
    private let mainCategoryShimmerView = MainCategoryShimmerView()
    
    // MARK: Internal Properties
    internal var myProfileButtonAction: (() -> Void)?
    internal var addAdsButtonAction: (() -> Void)?
    internal var refreshDataAction: ((String) -> Void)?

    // MARK: Private Methods
    private func configureSearchBar() {
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    }
    
    private func configureButtons() {
        myProfileButton.setImage(Asset.avatarIcon.image, for: .normal)
        myProfileButton.addTarget(self, action: #selector(myProfileButtonTap), for: .touchUpInside)
        addAdsButton.addTarget(self, action: #selector(addAdsButtonTap), for: .touchUpInside)
    }
    
    private func configureCollectionViews() {
        adCollectionView.register(AdCollectionViewCell.self, forCellWithReuseIdentifier: AdCollectionViewCell.identifier)
        adCollectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        adCollectionView.register(FooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.identifier)
        
        categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        categoryCollectionView.backgroundColor = Asset.backgroundColor.color
        adCollectionView.backgroundColor = Asset.backgroundColor.color
    }
    
    @objc private func myProfileButtonTap() {
        myProfileButtonAction?()
    }
    
    @objc private func addAdsButtonTap() {
        addAdsButtonAction?()
    }
    
    @objc private func refreshControlTap() {
        refreshDataAction?("1")
        refreshControl.endRefreshing()
    }
    
    // MARK: Internal Methods
    internal override func onConfigureView() {
        configureSearchBar()
        configureCollectionViews()
        configureButtons()

        refreshControl.addTarget(self, action: #selector(refreshControlTap), for: .valueChanged)
        
        backgroundColor = Asset.backgroundColor.color
    }
    
    internal override func onAddSubViews() {
        addSubview(searchBar)
        addSubview(myProfileButton)
        addSubview(categoryCollectionView)
        addSubview(adCollectionView)
        adCollectionView.addSubview(refreshControl)
        addSubview(mainShimmerView)
        addSubview(mainCategoryShimmerView)
        addSubview(addAdsButton)
    }
 
    internal override func onSetUpConstraints() {
        
        searchBar.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(50)
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(32)
        }
        
        myProfileButton.snp.makeConstraints {
            $0.height.width.equalTo(24)
            $0.left.equalTo(13)
            $0.centerY.equalTo(searchBar.snp.centerY)
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.left.right.equalTo(safeAreaLayoutGuide)
            $0.top.equalTo(searchBar.snp.bottom).offset(11)
            $0.height.equalTo(53)
        }
        
        adCollectionView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(12)
            $0.bottom.equalTo(0)
        }
        
        addAdsButton.snp.makeConstraints {
            $0.height.equalTo(57)
            $0.width.equalTo(57)
            $0.bottom.equalTo(snp.bottom).offset(-21)
            $0.centerX.equalTo(snp.centerX)
        }

        mainShimmerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        mainCategoryShimmerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    internal func configCollectionView(adDataSource: AdCollectionViewDataSource,
                                       categoryDataSource: CategoryCollectionViewDataSource,
                                       searchBarDelegate: UISearchBarDelegate) {
        adCollectionView.dataSource = adDataSource
        adCollectionView.delegate = adDataSource
        adDataSource.hideViews = hideViews
        categoryCollectionView.dataSource = categoryDataSource
        categoryCollectionView.delegate = categoryDataSource
        searchBar.delegate = searchBarDelegate
    }
    
    internal func adCollectionViewReloadData() {
        adCollectionView.reloadData()
        if adCollectionView.numberOfSections > 0 {
            mainShimmerView.removeFromSuperview()
        }
    }
    
    internal func categoryCollectionViewReloadData() {
        categoryCollectionView.reloadData()
        if categoryCollectionView.numberOfSections > 0 {
            mainCategoryShimmerView.removeFromSuperview()
        }
    }
    
    internal func closeSearchBar() {
        searchBar.endEditing(true)
        searchBar.text = nil
        adCollectionView.contentOffset.y = 0
    }
    
    internal func hideViews(_ isHide: Bool) {
        if isHide {
            adCollectionView.snp.remakeConstraints {
                $0.left.right.equalToSuperview()
                $0.top.equalTo(safeAreaLayoutGuide)
                $0.bottom.equalTo(0)
            }
            searchBar.endEditing(true)
        } else {
            adCollectionView.snp.remakeConstraints {
                $0.left.right.equalToSuperview()
                $0.top.equalTo(categoryCollectionView.snp.bottom).offset(12)
                $0.bottom.equalTo(0)
            }
        }

        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.adCollectionView.superview?.layoutIfNeeded()
        }
        
        myProfileButton.isHidden = isHide
        searchBar.isHidden = isHide
        categoryCollectionView.isHidden = isHide
        addAdsButton.isHidden = isHide
    }
}
