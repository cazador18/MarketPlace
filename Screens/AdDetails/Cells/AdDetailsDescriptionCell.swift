import Foundation
import UIKit
import SnapKit

internal struct AdDetailsDescriptionCellData {
    internal let title: String
    internal let description: String
}

internal class AdDetailsDescriptionCell: BaseUITableViewCell {

    internal func set(_ data: AdDetailsDescriptionCellData) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
    }

    internal func setup(for tableView: UITableView) {
        let descriptionTextSize = descriptionLabel.textRect(
            forBounds: CGRect(x: 0.0, y: 0.0, width: tableView.frame.width - 32.0, height: .infinity),
            limitedToNumberOfLines: 0).size

        if descriptionTextSize.height <= 54 {
            descriptionTitleHeight.deactivate()
            fullDescriptionButton.isHidden = true
        } else {
            descriptionTitleHeight.activate()
            fullDescriptionButton.isHidden = false
        }
    }

    // MARK: - Properties
    internal static let identifier = "adDetailsDescriptionCell"

    private let stackView = UIStackView()
    private var titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private var fullDescriptionButton = UIButton()
    private var descriptionTitleHeight: Constraint!
    
    // MARK: - Lifecycle
    internal override func onConfigureCell() {
        super.onConfigureCell()
        backgroundColor = nil
        backgroundView = UIView()
        stackView.axis = .vertical

        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(asset: Asset.tittleTextColor)
        titleLabel.font = UIFont(name: FontFamily.SFProText.semibold.name, size: 17)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = UIColor(asset: Asset.primaryTextColor)
        descriptionLabel.font = UIFont(name: FontFamily.SFProText.regular.name, size: 15)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.setContentHuggingPriority(.required, for: .vertical)
        descriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        fullDescriptionButton.setTitle("Все описание", for: .normal)
        fullDescriptionButton.titleLabel?.font = UIFont(name: FontFamily.SFProText.regular.name, size: 17)!
        fullDescriptionButton.setTitleColor(UIColor(asset: Asset.blueTextColor), for: .normal)
        fullDescriptionButton.contentHorizontalAlignment = .left
        fullDescriptionButton.setContentHuggingPriority(.required, for: .vertical)
        fullDescriptionButton.setContentCompressionResistancePriority(.required, for: .vertical)
        fullDescriptionButton.addTarget(self,
                                        action: #selector(fullDescriptionButtonTapped),
                                        for: .touchUpInside)

    }

    @objc func fullDescriptionButtonTapped() {
        if descriptionTitleHeight.isActive {
            descriptionTitleHeight.deactivate()
            fullDescriptionButton.setTitle("Скрыть", for: .normal)
        } else {
            fullDescriptionButton.setTitle("Все описание", for: .normal)
            descriptionTitleHeight.activate()
        }

        if let tableView = superview as? UITableView {
            tableView.performBatchUpdates(nil)
        }
    }

    internal override func onAddSubviews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.setCustomSpacing(8, after: titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.setCustomSpacing(2, after: descriptionLabel)
        stackView.addArrangedSubview(fullDescriptionButton)
    }


    internal override func onSetUpConstraints() {
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().priority(.high)
        }

        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints { make in
            descriptionTitleHeight = make.height.equalTo(54).constraint
        }
    }
}
