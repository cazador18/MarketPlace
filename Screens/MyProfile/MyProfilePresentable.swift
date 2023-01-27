import UIKit
import SnapKit

internal final class MyProfilePresentable: BaseView {
    
    // MARK: - Properties
    internal let myProfileHeaderTableView: UITableView = .init(frame: .zero, style: .insetGrouped)
    internal let emptyAdsImageView: UIImageView = .init()
    internal let emptyAdsInfoLabel: UILabel = .init()
    internal let myProfileCollectionView: BaseUICollectionView = .init()
    internal let dataSource = MyProfileCollectionViewDataSource()
    internal var segmentControl: UISegmentedControl = .init(items: ["Активные", "Неактивные"])
    
    private lazy var refreshControl: UIRefreshControl = .init()
    
    // MARK: - Methods
    internal override func onConfigureView() {
        backgroundColor = .systemGroupedBackground
        refreshControl.addTarget(self, action: #selector(refreshControlTap), for: .valueChanged)
        
        myProfileHeaderTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        
        myProfileHeaderTableView.delegate = self
        myProfileHeaderTableView.dataSource = self
        myProfileHeaderTableView.tableHeaderView = UIView(frame: CGRect(x: .zero, y: .zero, width: .zero, height: CGFloat.leastNonzeroMagnitude))
        myProfileHeaderTableView.isScrollEnabled = false
        myProfileHeaderTableView.layoutMargins = .init(top: 0, left: 5, bottom: 0, right: 5)
        
        emptyAdsImageView.image = Asset.emptyImg.image
        
        emptyAdsInfoLabel.font = UIFont(name: FontFamily.SFProText.regular.name, size: 15)
        emptyAdsInfoLabel.textColor = Asset.secondaryTextColor.color
        emptyAdsInfoLabel.textAlignment = .center
        emptyAdsInfoLabel.text = "У вас пока нет объявлений"
        emptyAdsInfoLabel.numberOfLines = 0
        
        emptyAdsImageView.isHidden = true
        emptyAdsInfoLabel.isHidden = true
        
        myProfileCollectionView.backgroundColor = .clear
        myProfileCollectionView.register(MyProfileUICollectionViewCell.self, forCellWithReuseIdentifier: MyProfileUICollectionViewCell.identifier)
        myProfileCollectionView.register(FooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.identifier)
        myProfileCollectionView.delegate = dataSource
        myProfileCollectionView.dataSource = dataSource
        
        segmentControl.selectedSegmentIndex = 0
        segmentControl.selectedSegmentTintColor = .white
        segmentControl.backgroundColor = UIColor(asset: Asset.backgroundColor)
        segmentControl.layer.cornerRadius = 9
        segmentControl.addTarget(self, action: #selector(selectedSegment(_:)), for: .valueChanged)
    }
    
    internal override func onAddSubViews() {
        addSubview(myProfileHeaderTableView)
        addSubview(emptyAdsImageView)
        addSubview(emptyAdsInfoLabel)
        addSubview(myProfileCollectionView)
        addSubview(segmentControl)
        myProfileCollectionView.addSubview(refreshControl)
    }
    
    internal override func onSetUpConstraints() {
        myProfileHeaderTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(8)
            $0.height.equalTo(76)
        }
        
        emptyAdsImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        emptyAdsInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(emptyAdsImageView).offset(-8)
            $0.trailing.equalTo(emptyAdsImageView).offset(8)
            $0.top.equalTo(emptyAdsImageView.snp.bottom).offset(16)
        }
        
        myProfileCollectionView.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        segmentControl.snp.makeConstraints {
            $0.top.equalTo(myProfileHeaderTableView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(myProfileCollectionView.snp.top).offset(-16)
        }
    }
    
    internal func populateDataSource(ads: [MyAds], nextPage: Int?) {
        dataSource.populateDataSource(ads: ads, nextPage: nextPage)
        myProfileCollectionView.reloadData()
    }
    
    internal func refreshMyAds() {
        dataSource.clean()
        dataSource.changePage?("1", segmentControl.selectedSegmentIndex)
        refreshControl.endRefreshing()
    }
    
    @objc private func selectedSegment(_ sender: UISegmentedControl) {
        myProfileCollectionView.isHidden = false
        emptyAdsImageView.isHidden = true
        emptyAdsInfoLabel.isHidden = true
        
        dataSource.clean()
        dataSource.statusAds = sender.selectedSegmentIndex
        dataSource.changePage?("1", sender.selectedSegmentIndex)
    }
    
    @objc private func refreshControlTap() {
        refreshMyAds()
    }

    // MARK: - View state
    internal func showEmptyAdsState() {
        myProfileCollectionView.isHidden = true
        emptyAdsImageView.isHidden = false
        emptyAdsInfoLabel.isHidden = false
    }
}
// MARK: - UITableViewDelegate
extension MyProfilePresentable: UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MyProfilePresentable: UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as? ProfileTableViewCell,
              let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber")
        else {
            return ProfileTableViewCell()
        }
        cell.configure(phoneNumber: phoneNumber)
        return cell
    }
}
