import Foundation
import UIKit
import SnapKit

class Error500VC: UIViewController {
    lazy var errorImage: UIImageView! = {
        let image = UIImage(asset: Asset.error500)
        let imageView = UIImageView(image: image!)
        return imageView
    }()

    lazy var primaryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.textColor = UIColor(asset: Asset.primaryTextColor)
        label.text = "Ошибка"
        return label
    }()

    lazy var secondaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(asset: Asset.secondaryTextColor)
        label.text = "Сервис временно не доступен. Уже исправляем"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        self.view.addSubview(errorImage)
        self.view.addSubview(primaryLabel)
        self.view.addSubview(secondaryLabel)

        self.errorImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(38)
            make.trailing.equalToSuperview().inset(38)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(51.36)
            make.height.equalTo(300)
        }

        self.primaryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(128)
            make.trailing.equalToSuperview().inset(129)
            make.top.equalTo(errorImage.snp.bottom)
        }

        self.secondaryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(27)
            make.trailing.equalToSuperview().inset(27)
            make.top.equalTo(primaryLabel.snp.bottom).offset(16)
        }
    }
}
