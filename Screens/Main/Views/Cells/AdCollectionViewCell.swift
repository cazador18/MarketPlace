import UIKit
import SnapKit
import Kingfisher

internal final class AdCollectionViewCell: BaseCollectionViewCell {
    
    internal static let identifier = "AdCollectionViewCell"

    // MARK: - Private Properties
    private let pageControl: CustomPageControl = {
        let pageControl = CustomPageControl()
        return pageControl
    }()
    
    private lazy var adScrollViewElement: AdScrollViewElement = .init()
    
    // MARK: - Private Methods
    private func textStyleConfig(text: String,
                                 currency: String,
                                 isStrike: Bool) -> NSMutableAttributedString {
        let attributedText: NSMutableAttributedString = .init(string: text)

        if currency == "som" {
            let textRangeUnderLine: NSRange = .init(location: text.count - 1, length: 1)
            
            attributedText.addAttribute(.underlineStyle,
                                        value: 1,
                                        range: textRangeUnderLine)
            if isStrike {
                let textRangeStrike: NSRange = .init(location: 0, length: text.count - 1)
                attributedText.addAttribute(.strikethroughStyle,
                                            value: 1,
                                            range: textRangeStrike)
            }
        } else {
            if isStrike {
                let textRangeStrike: NSRange = .init(location: 1, length: text.count - 1)
                attributedText.addAttribute(.strikethroughStyle,
                                            value: 1,
                                            range: textRangeStrike)
            }
        }

        return attributedText
    }
    
    private func emptyImageView() {
        let imageView: UIImageView = .init(image: Asset.emptyImg.image)

        adScrollViewElement.setupImages(imageArray: [imageView],
                                        size: frame.width)
    }
    
    private func cutOldPrice(_ text: String) -> String {
        if let lastIndex = text.firstIndex(of: " ") {
            let price = text[...lastIndex]
            return String(price)
        }
        return text
    }
    
    private func convertAnyToString(priceAny: Any?) -> String? {
        var priceString: String?
        
        if let price: String = priceAny as? String {
            priceString =  price
        }
        
        if let price: Int = priceAny as? Int {
            priceString = String(price)
        }
        
        return priceString
    }
    
    // MARK: - Internal Methods
    internal override func onConfigureCell() {
        super.onConfigureCell()
        adImageView.isHidden = true
        adImageView.removeFromSuperview()
        adScrollViewElement.isUserInteractionEnabled = false
        contentView.addGestureRecognizer(adScrollViewElement.panGestureRecognizer)
        adScrollViewElement.delegate = self
    }
    
    internal override func onAddSubviews() {
        super.onAddSubviews()
        contentView.addSubview(adScrollViewElement)
        addSubview(pageControl)
    }
    
    internal override func onSetUpConstraints() {
        super.onSetUpConstraints()
        adScrollViewElement.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(112)
        }
        
        pageControl.snp.makeConstraints {
            $0.width.equalTo(pageControl.frame.size.width)
            $0.height.equalTo(pageControl.frame.size.height)
            $0.left.equalToSuperview().inset(6)
            $0.bottom.equalToSuperview().inset(118)
        }
    }
    
    internal override func prepareForReuse() {
        super.prepareForReuse()

        for subview in adScrollViewElement.subviews {
            subview.removeFromSuperview()
        }

        priceLabel.text = nil
        oldPriceLabel.text = nil
        titleLabel.text = nil
        categoryNameLabel.text = nil
        locationLabel.text = nil
    }
    
    internal func configure(_ adElement: AdElement) {
        let numberFormatter: NumberFormatter = .init()

        if let price = convertAnyToString(priceAny: adElement.price),
           let priceNumber = numberFormatter.number(from: price),
           let currency = adElement.currency,
           let separatedNumber = NumberFormatter.withSeparator.string(from: priceNumber) {
            priceLabel.text = separatedNumber
            if currency == "som" {
                let text: String = separatedNumber + " c"
                priceLabel.attributedText? = textStyleConfig(text: text,
                                                             currency: currency,
                                                             isStrike: false)
            } else {
                let text: String = "$" + separatedNumber
                priceLabel.attributedText? = textStyleConfig(text: text,
                                                             currency: currency,
                                                             isStrike: false)
            }
        }
        
        if let price = adElement.oldPrice,
           let priceNumber = numberFormatter.number(from: cutOldPrice(price)),
           let currency = adElement.oldPrice?.last,
           let separatedNumber = NumberFormatter.withSeparator.string(from: priceNumber) {
            oldPriceLabel.text = separatedNumber
            if currency == "с" {
                let text: String = separatedNumber + " c"
                oldPriceLabel.attributedText? = textStyleConfig(text: text,
                                                                currency: "som",
                                                                isStrike: true)
            } else {
                let text: String = "$" + separatedNumber
                oldPriceLabel.attributedText? = textStyleConfig(text: text,
                                                                currency: "usd",
                                                                isStrike: true)
            }
        }

        if let title = adElement.title,
           let category = adElement.category,
           let location = adElement.location {
            titleLabel.text = title
            categoryNameLabel.text = category.name
            locationLabel.text = location.name
        }
        
        if let oMoneyPay = adElement.oMoneyPay {
            if !oMoneyPay {
                oMoneyImageView.isHidden = true
            } else {
                oMoneyImageView.isHidden = false
            }
        }
        
        if let images = adElement.minifyImages {
            let urlImages: [URL?] = images.map { URL(string: $0) }
            let images: [UIImageView] = urlImages.map { url in
                let image = UIImageView()
                image.kf.setImage(with: url)
                return image
            }
            if images.isEmpty {
                emptyImageView()
            } else {
                adScrollViewElement.setupImages(imageArray: images, size: frame.width)
            }
            pageControl.numberOfPages = images.count
        }
    }
}

extension AdCollectionViewCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(adScrollViewElement.contentOffset.x / adScrollViewElement.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
}
