import UIKit
import SnapKit

class FaqCustomDetailView: UIView {
    internal let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 0
        label.textColor = UIColor(asset: Asset.secondTextColor)
        label.font = FontFamily.SFProText.regular.font(size: 15)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(snp.top)
            $0.leading.equalTo(snp.leading).offset(12)
            $0.trailing.equalTo(snp.trailing).offset(-12)
            $0.bottom.equalTo(snp.bottom)
        }
    }
    internal func setUI(with string: String) {
        descriptionLabel.text = string
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
