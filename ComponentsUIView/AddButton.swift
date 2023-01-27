import UIKit
import SnapKit
class AddButton: UIButton {
    let imageAddButton: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .center
        image.image = UIImage(asset: Asset.addIcon)
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(imageAddButton)
        imageAddButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
