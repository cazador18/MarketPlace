import UIKit
import SnapKit

internal class CategoryChooseCustomTableViewCell: UITableViewCell {
    private var image: UIImageView = .init()
    private var title: UILabel = .init()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(title)
        addSubview(image)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        image.snp.makeConstraints({
            $0.top.equalTo(snp.top).offset(8)
            $0.leading.equalTo(snp.leading).offset(8)
            $0.width.height.equalTo(28)
        })
        title.snp.makeConstraints({
            $0.top.equalTo(snp.top).offset(12)
            $0.leading.equalTo(image.snp.trailing).offset(12)
            $0.trailing.equalTo(snp.trailing).offset(-32)
            $0.bottom.equalTo(snp.bottom).offset(-12)
        })
    }
    
    public func updateTitle(title: String) {
        self.title.text = title
    }
    
    public func updateImage(image: String) {
        if let url: URL = .init(string: image) {
            self.image.kf.setImage(with: url)
        }
    }
}
