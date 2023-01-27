import Foundation
import UIKit
import SnapKit

struct AdDetailsPriceAndAuthorCellData {
    enum Currency {
        case kgs, usd
    }

    let price: Double
    let currency: Currency
    let acceptsOMoney: Bool
    let isVerifiedNumber: Bool
    let authorName: String
}

class AdDetailsPriceAndAuthorCell: BaseUITableViewCell {
    func set(_ data: AdDetailsPriceAndAuthorCellData) {
        priceLabel.attributedText = data.currency.currencyString(for: data.price)
        oMoneyStackView.isHidden = !data.acceptsOMoney
        isVerifiedStackView.isHidden = !data.isVerifiedNumber
        authorNameLabel.text = data.authorName
    }
    // MARK: - Properties
    internal static let identifier = "adDetailsPriceAndAuthorCell"

    private let containerView = UIView()
    private let mainStackView = UIStackView()
    private let priceLabel = UILabel()
    private let oMoneyStackView = UIStackView()
    private var oMoneyPayImageView = UIImageView(image: Asset.oDengi.image)
    private let oMoneyPayLabel = UILabel()
    private let isVerifiedStackView = UIStackView()
    private var isVerifiedImageView = UIImageView(image: Asset.verifiedNumber.image)
    private let isVerifiedLabel = UILabel()
    private let authorStackView = UIStackView()
    private var authorAvatarImageView = UIImageView(image: Asset.emptyAvatar.image)
    private let authorNameLabel = UILabel()

    // MARK: - Lifecycle
    override func onConfigureCell() {
        super.onConfigureCell()
        backgroundColor = nil
        backgroundView = UIView()

        mainStackView.axis = .vertical
        mainStackView.spacing = 8
        oMoneyStackView.axis = .horizontal
        oMoneyStackView.spacing = 8
        oMoneyStackView.alignment = .center
        isVerifiedStackView.axis = .horizontal
        isVerifiedStackView.spacing = 7
        isVerifiedStackView.alignment = .center
        authorStackView.axis = .horizontal
        authorStackView.spacing = 14
        authorStackView.alignment = .center

        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 12

        priceLabel.textAlignment = .left
        priceLabel.textColor = UIColor(asset: Asset.tittleTextColor)
        priceLabel.font = UIFont(name: FontFamily.SFProText.semibold.name, size: 22)

        oMoneyPayImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        oMoneyPayImageView.setContentHuggingPriority(.required, for: .horizontal)

        oMoneyPayLabel.text = "Продавец принимает О!Деньги, свяжитесь с продавцом для уточнения деталей"
        oMoneyPayLabel.numberOfLines = 0
        oMoneyPayLabel.textAlignment = .left
        oMoneyPayLabel.textColor = UIColor(asset: Asset.normalTextColor)
        oMoneyPayLabel.font = UIFont(name: FontFamily.SFProText.regular.name, size: 15)

        isVerifiedImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        isVerifiedImageView.setContentHuggingPriority(.required, for: .horizontal)

        isVerifiedLabel.text = "Подтвержденный номер"
        isVerifiedLabel.textAlignment = .left
        isVerifiedLabel.textColor = UIColor(asset: Asset.normalTextColor)
        isVerifiedLabel.font = UIFont(name: FontFamily.SFProText.regular.name, size: 15)

        authorAvatarImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        authorAvatarImageView.setContentHuggingPriority(.required, for: .horizontal)

        authorNameLabel.textAlignment = .left
        authorNameLabel.textColor = UIColor(asset: Asset.tittleTextColor)
        authorNameLabel.font = UIFont(name: FontFamily.SFProText.regular.name, size: 17)
    }

    override func onAddSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(priceLabel)
        mainStackView.addArrangedSubview(oMoneyStackView)
        var spacingView = UIView()
        oMoneyStackView.addArrangedSubview(spacingView)
        oMoneyStackView.setCustomSpacing(6, after: spacingView)
        spacingView.snp.makeConstraints { $0.width.equalTo(0) }
        oMoneyStackView.addArrangedSubview(oMoneyPayImageView)
        oMoneyStackView.addArrangedSubview(oMoneyPayLabel)
        mainStackView.addArrangedSubview(isVerifiedStackView)
        spacingView = UIView()
        isVerifiedStackView.addArrangedSubview(spacingView)
        isVerifiedStackView.setCustomSpacing(5, after: spacingView)
        spacingView.snp.makeConstraints { $0.width.equalTo(0) }
        isVerifiedStackView.addArrangedSubview(isVerifiedImageView)
        isVerifiedStackView.addArrangedSubview(isVerifiedLabel)
        mainStackView.addArrangedSubview(authorStackView)
        authorStackView.addArrangedSubview(authorAvatarImageView)
        authorStackView.addArrangedSubview(authorNameLabel)
    }

    override func onSetUpConstraints() {
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.verticalEdges.equalToSuperview()
        }

        mainStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
        }

        authorStackView.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
    }
}

extension AdDetailsPriceAndAuthorCellData.Currency {

    func currencyString(for price: Double) -> NSAttributedString {
        let bigFont = UIFont.systemFont(ofSize: 22, weight: .bold)
        let smallFont = UIFont.systemFont(ofSize: 14, weight: .bold)

        switch self {
        case .kgs:
            AdDetailsPriceAndAuthorCellData.Currency.currencyFormatter.currencySymbol = "c̲"
            AdDetailsPriceAndAuthorCellData.Currency.currencyFormatter.locale = Locale(identifier: "ru_KG")
            AdDetailsPriceAndAuthorCellData.Currency.currencyFormatter.minimumFractionDigits = 0
            AdDetailsPriceAndAuthorCellData.Currency.currencyFormatter.maximumFractionDigits = 0
            let string = AdDetailsPriceAndAuthorCellData.Currency.currencyFormatter.string(from: price as NSNumber)!
            return NSAttributedString(string: string, attributes: [.font: bigFont])
        case .usd:
            AdDetailsPriceAndAuthorCellData.Currency.currencyFormatter.currencySymbol = nil
            AdDetailsPriceAndAuthorCellData.Currency.currencyFormatter.locale = Locale(identifier: "en_US")
            AdDetailsPriceAndAuthorCellData.Currency.currencyFormatter.minimumFractionDigits = 2
            AdDetailsPriceAndAuthorCellData.Currency.currencyFormatter.maximumFractionDigits = 2
            let string = AdDetailsPriceAndAuthorCellData.Currency.currencyFormatter.string(from: price as NSNumber)!
            let result = NSMutableAttributedString(string: string, attributes: [.font: bigFont])
            let separatorRange = (string as NSString).range(of: AdDetailsPriceAndAuthorCellData.Currency.currencyFormatter.currencyDecimalSeparator)
            if separatorRange.location != NSNotFound {
                result.addAttributes([.font: smallFont,
                                      .baselineOffset: bigFont.capHeight - smallFont.capHeight],
                                     range: NSRange(location: separatorRange.location + 1,
                                                    length: string.count - separatorRange.location - 1))
            }

            return result
        }
    }

    static let currencyFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        return currencyFormatter
    }()
}
