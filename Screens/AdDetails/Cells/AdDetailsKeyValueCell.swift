import Foundation
import UIKit
import SnapKit

struct AdDetailsKeyValueCellData {
    let key: String
    let value: String
}

class AdDetailsKeyValueCell: BaseUITableViewCell {
    func set(_ data: AdDetailsKeyValueCellData) {
        keyLabel.text = data.key
        valueLabel.text = data.value
    }
    // MARK: - Properties
    internal static let identifier = "adDetailsKeyValueCell"
    private let stackView = UIStackView()
    let containerView = UIView()
    private let keyLabel = UILabel()
    private let valueLabel = UILabel()
    let separatorView = UIView()

    // MARK: - Lifecycle
    override func onConfigureCell() {
        super.onConfigureCell()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        backgroundColor = nil
        backgroundView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8

        separatorView.backgroundColor = .lightGray


        keyLabel.textColor = UIColor(asset: Asset.primaryTextColor)
        keyLabel.font = UIFont(name: FontFamily.SFProText.regular.name, size: 15)

        valueLabel.textColor = UIColor(asset: Asset.tittleTextColor)
        valueLabel.font = UIFont(name: FontFamily.SFProText.regular.name, size: 15)
    }

    override func onAddSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(stackView)
        containerView.addSubview(separatorView)
        stackView.addArrangedSubview(keyLabel)
        stackView.addArrangedSubview(valueLabel)
    }

    override func onSetUpConstraints() {
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.verticalEdges.equalToSuperview()
            make.height.equalTo(44)
        }

        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        separatorView.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.leading.equalToSuperview().inset(8)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
