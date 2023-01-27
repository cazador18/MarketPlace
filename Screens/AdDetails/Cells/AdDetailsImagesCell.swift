import Foundation
import UIKit
import Kingfisher

struct AdDetailsImagesCellData {
    let images: [URL]
    let isVerified: Bool
}

internal protocol AdDetailsImagesCellDelegate: AnyObject {
    func imageCellDidTap(_ cell: AdDetailsImagesCell)
}

internal class AdDetailsImagesCell: BaseUITableViewCell {

    internal func set(_ data: AdDetailsImagesCellData) {
        emptyImageView.isHidden = !data.images.isEmpty
        sliderView.imageUrls = data.images
        countOfPhotosView.isHidden = data.images.isEmpty
        isVerifiedImageView.isHidden = !data.isVerified
    }

    // MARK: - Properties
    internal static let identifier = "adDetailsImagesCell"

    internal let sliderView = ImageSliderView()
    private let emptyImageView = UIImageView(image: Asset.emptyImg.image)
    private var isVerifiedImageView = UIImageView(image: Asset.profileCheck.image)
    private let countOfPhotosView = UIView()
    private let countLabel = UILabel()

    weak var delegate: AdDetailsImagesCellDelegate?

    // MARK: - Lifecycle
    internal override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.updateCountLabel()
        }
    }

    internal override func onConfigureCell() {
        super.onConfigureCell()
        emptyImageView.contentMode = .scaleAspectFit
        countOfPhotosView.backgroundColor = .darkGray.withAlphaComponent(0.5)
        countOfPhotosView.layer.cornerRadius = 11
        countLabel.font = UIFont(name: FontFamily.SFProText.regular.name, size: 13)
        countLabel.textColor = .white
        countLabel.textAlignment = .center

        sliderView.delegate = self
    }

    internal override func onAddSubviews() {
        contentView.addSubview(emptyImageView)
        contentView.addSubview(sliderView)
        contentView.addSubview(isVerifiedImageView)
        contentView.addSubview(countOfPhotosView)
        countOfPhotosView.addSubview(countLabel)
    }

    internal override func onSetUpConstraints() {
        emptyImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        sliderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(sliderView.snp.height).multipliedBy(375.0 / 240.0).priority(999)
        }

        isVerifiedImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
        }

        countOfPhotosView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
        }

        countLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.verticalEdges.equalToSuperview().inset(3 )
        }
    }

    private func updateCountLabel() {
        guard let index = sliderView.visibleImageIndex else { return }
        let totalAmount = sliderView.imageUrls.count
        countLabel.text = "\(index + 1)/\(totalAmount)"
    }
}

extension AdDetailsImagesCell: ImageSliderViewDelegate {

    internal func imageSliderView(_ imageSliderView: ImageSliderView, didSwipeToImageAt index: Int) {
        updateCountLabel()
    }

    internal func imageSliderViewDidTap(_ imagesliderView: ImageSliderView) {
        delegate?.imageCellDidTap(self)
    }
}
