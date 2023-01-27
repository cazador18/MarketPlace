import UIKit
import SnapKit
import Kingfisher

internal final class CategoryCollectionViewCell: UICollectionViewCell {
    
    internal static let identifier = "CategoryCollectionViewCell"
    
    // MARK: - Private Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.emptyImg.image
        imageView.backgroundColor = Asset.categoryBackgroundColor.color
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: FontFamily.SFProText.regular.name, size: 11)
        titleLabel.textAlignment = .center
        return titleLabel
    }()

    // MARK: - Initializers
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        onAddSubviews()
        onSetUpConstraints()
    }
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func onAddSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
    }
    private func onSetUpConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-17)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    internal override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = Asset.emptyImg.image
    }
    
    // MARK: - Internal Methods
    internal func configureCell(title: String, imageUrl: String) {
        titleLabel.text = title
        if let url: URL = .init(string: imageUrl) {
            imageView.kf.setImage(with: url)
        }
        imageView.contentMode = .scaleAspectFill
    }
    
    internal func configureAllCategoryCell() {
        titleLabel.text = "Все"
        imageView.image = Asset.union.image
        imageView.contentMode = .center
    }
}
