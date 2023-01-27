import UIKit
import SnapKit

class FAQCustomTableViewCellView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 0
        label.font = FontFamily.SFProText.regular.font(size: 17)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
        backgroundColor = .clear
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(16)
            $0.leading.equalTo(snp.leading).offset(16)
            $0.trailing.equalTo(snp.trailing).offset(-16)
            $0.bottom.equalTo(snp.bottom)
        }
    }
    
    internal func setTitleText(with string: String) {
        titleLabel.text = string
    }
}
