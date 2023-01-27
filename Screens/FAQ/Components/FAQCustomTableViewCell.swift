import UIKit
import SnapKit

internal class FAQTableViewCell: UITableViewCell {
    private var maskButton: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = Asset.mask.image
        image.contentMode = .center
        image.backgroundColor = .clear
        return image
    }()
    private let titleLabel: FAQCustomTableViewCellView = .init()
    private let descriptionLabel: FaqCustomDetailView = .init()
    private let containerView: UIStackView = .init()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        layer.cornerRadius = 10
        addSubviews()
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    private func addSubviews() {
        addSubview(containerView)
        containerView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(descriptionLabel)
        addSubview(maskButton)
    }
    internal func updateImage(image: ImageAsset) {
        maskButton.image = UIImage(asset: image)
    }
    
    internal func updateTitleText(wuth string: String) {
        titleLabel.setTitleText(with: string )
    }
    internal func updateDescriptionText(wuth string: String) {
        descriptionLabel.setUI(with: string )
    }

    private func setupViews() {
        selectionStyle = .none
        descriptionLabel.isHidden = true
        containerView.axis = .vertical
        containerView.layer.cornerRadius = 10
        containerView.spacing = 10
        containerView.snp.makeConstraints {
            $0.top.equalTo(snp.top)
            $0.leading.equalTo(snp.leading)
            $0.trailing.equalTo(snp.trailing)
            $0.bottom.equalTo(snp.bottom).offset(-12)
        }
        maskButton.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(22)
            $0.trailing.equalTo(snp.trailing).offset(-22)
        }
        
    }
}
extension FAQTableViewCell {
    var isDetailViewHidden: Bool {
            return descriptionLabel.isHidden
        }

        func showDetailView() {
            descriptionLabel.isHidden = false
            maskButton.image = Asset.unMask.image
        }

        func hideDetailView() {
            descriptionLabel.isHidden = true
            maskButton.image = Asset.mask.image
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            if isDetailViewHidden, selected {
                showDetailView()
                
            } else {
                hideDetailView()
            }
        }
}
