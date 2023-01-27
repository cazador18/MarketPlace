import Foundation
import UIKit
internal class StartPageView: UIView {
    let stackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 16
        view.axis = .vertical
        view.alignment = .center
        return view
    }()

    let primaryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.textColor = UIColor(asset: Asset.primaryTextColor)
        return label
    }()

    let secondaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(asset: Asset.secondaryTextColor)
        return label
    }()

    let primaryButton = PrimaryButton()

    let imageView: UIImageView! = {
        let imageView = UIImageView()
        return imageView
    }()

    internal override init(frame: CGRect) {
        super.init(frame: frame)

        primaryButton.setBackgroundImage(UIColor(asset: Asset.primaryButtonColor)!.pointImage(), for: .normal)
        backgroundColor = UIColor(asset: Asset.backgroundColor)

        addSubview(stackView)
        addSubview(primaryButton)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(primaryLabel)
        stackView.addArrangedSubview(secondaryLabel)
        stackView.setCustomSpacing(32, after: imageView)
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.centerY.equalToSuperview().offset(-30)
        }
        primaryButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.height.equalTo(48)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(57)
        }
    }
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
