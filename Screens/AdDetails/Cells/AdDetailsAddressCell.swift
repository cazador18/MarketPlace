import Foundation
import UIKit
import SnapKit

struct AdDetailsAddressCellData {
    let address: String
}

internal class AdDetailsAddressCell: BaseUITableViewCell {
    internal func set(_ data: AdDetailsAddressCellData) {
        addressLabel.text = data.address
    }
    // MARK: - Properties
    internal static let identifier = "adDetailsAddressCell"
    private let containerView = UIView()
    private let stackView = UIStackView()
    private let addressImageView = UIImageView(image: Asset.mapIcon.image)
    private let addressLabel = UILabel()

    // MARK: - Lifecycle
    override func onConfigureCell() {
        super.onConfigureCell()
        backgroundColor = nil
        backgroundView = UIView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8


        addressLabel.textColor = UIColor(asset: Asset.normalTextColor)
        addressLabel.font = UIFont(name: FontFamily.SFProText.regular.name, size: 17)

        addressImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        addressImageView.setContentHuggingPriority(.required, for: .horizontal)

    }

    override func onAddSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(addressImageView)
        stackView.addArrangedSubview(addressLabel)
    }

    override func onSetUpConstraints() {
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.verticalEdges.equalToSuperview()
            make.height.equalTo(44)
        }

        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.verticalEdges.equalToSuperview().inset(8)
        }
    }
}
