import Foundation
import UIKit
import SnapKit

internal struct AdDetailsSection {
    let rows: [AdDetailsRow]
}

internal enum AdDetailsRow {
    case images(AdDetailsImagesCellData)
    case description(AdDetailsDescriptionCellData)
    case priceAndAuthor(AdDetailsPriceAndAuthorCellData)
    case keyValue(AdDetailsKeyValueCellData)
    case address(AdDetailsAddressCellData)
}

internal class AdDetailsPresentable: BaseView {

    internal var sections: [AdDetailsSection] = [] {
        didSet {
            footerView.isHidden = sections.isEmpty
            tableView.reloadData()
            if self.tableView.numberOfSections > 0 {
                shimmerView.removeFromSuperview()
            }
        }
    }
    private let tableView = UITableView()
    private let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 390, height: 120))
    private let shimmerView = AdDetailsShimmerView()
    internal let messageButton = UIButton()
    internal let callButton = PrimaryButton()
    internal let sliderView = ImageSliderView()
    internal var fullScreenImagesPresented: ((_ enteredFullScreen: Bool) -> Void)?

    internal override func onConfigureView() {
        footerView.isHidden = true
        sliderView.isHidden = true
        sliderView.delegate = self
        sliderView.zoomEnabled = true
        tableView.separatorStyle = .none
        tableView.contentInset.bottom = 8.0
        tableView.backgroundColor = .systemGroupedBackground
        tableView.register(AdDetailsImagesCell.self,
                           forCellReuseIdentifier: AdDetailsImagesCell.identifier)
        tableView.register(AdDetailsDescriptionCell.self,
                           forCellReuseIdentifier: AdDetailsDescriptionCell.identifier)
        tableView.register(AdDetailsPriceAndAuthorCell.self,
                           forCellReuseIdentifier: AdDetailsPriceAndAuthorCell.identifier)
        tableView.register(AdDetailsKeyValueCell.self,
                           forCellReuseIdentifier: AdDetailsKeyValueCell.identifier)
        tableView.register(AdDetailsAddressCell.self,
                           forCellReuseIdentifier: AdDetailsAddressCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self

        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }

        messageButton.setTitle("Написать", for: .normal)
        messageButton.titleLabel?.font = FontFamily.SFProText.semibold.font(size: 17)
        messageButton.setTitleColor(UIColor(asset: Asset.blueTextColor), for: .normal)
        messageButton.contentHorizontalAlignment = .center
        callButton.setTitle("Позвонить", for: .normal)
        callButton.titleLabel?.font = FontFamily.SFProText.semibold.font(size: 17)
    }

    internal override func onAddSubViews() {
        addSubview(tableView)
        addSubview(sliderView)
        addSubview(shimmerView)

        tableView.tableFooterView = footerView

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.addArrangedSubview(messageButton)
        stackView.addArrangedSubview(callButton)

        footerView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8).priority(999)
            make.top.equalToSuperview().inset(16)
        }
    }

    internal override func onSetUpConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        messageButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        callButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }

        sliderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        shimmerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
        }
    }
}

extension  AdDetailsPresentable: UITableViewDataSource {

    internal func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowData = sections[indexPath.section].rows[indexPath.row]
        switch rowData {
        case .images(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: AdDetailsImagesCell.identifier,
                                                     for: indexPath) as! AdDetailsImagesCell
            cell.set(data)
            cell.delegate = self
            return cell
        case .description(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: AdDetailsDescriptionCell.identifier,
                                                     for: indexPath) as! AdDetailsDescriptionCell
            cell.set(data)
            cell.setup(for: tableView)
            return cell
        case .priceAndAuthor(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: AdDetailsPriceAndAuthorCell.identifier,
                                                     for: indexPath) as! AdDetailsPriceAndAuthorCell
            cell.set(data)
            return cell
        case .keyValue(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: AdDetailsKeyValueCell.identifier,
                                                     for: indexPath) as! AdDetailsKeyValueCell
            cell.set(data)
            let numberOfRows = tableView.numberOfRows(inSection: indexPath.section)
            switch indexPath.row {
            case 0:
                cell.containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                cell.separatorView.isHidden = false
            case numberOfRows - 1:
                cell.containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                cell.separatorView.isHidden = true
            default:
                cell.containerView.layer.maskedCorners = []
                cell.separatorView.isHidden = false
            }
            return cell
        case .address(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: AdDetailsAddressCell.identifier,
                                                     for: indexPath) as! AdDetailsAddressCell
            cell.set(data)
            return cell
        }
    }
}

extension AdDetailsPresentable: UITableViewDelegate {

    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
}

extension AdDetailsPresentable: AdDetailsImagesCellDelegate {
    internal func imageCellDidTap(_ cell: AdDetailsImagesCell) {
        sliderView.isHidden = false
        fullScreenImagesPresented?(true)
        sliderView.visibleImageIndex = cell.sliderView.visibleImageIndex
    }
}

extension AdDetailsPresentable: ImageSliderViewDelegate {
    internal func imageSliderView(_ imageSliderView: ImageSliderView, didSwipeToImageAt index: Int) {

    }

    internal func imageSliderViewDidTap(_ imagesliderView: ImageSliderView) {
        sliderView.isHidden = true
        fullScreenImagesPresented?(false)
    }
}
