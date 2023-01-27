import UIKit

class PrimaryButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        layer.masksToBounds = true
        layer.cornerRadius = 8
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        configure()
    }

    private func configure() {
        setBackgroundImage(UIColor(asset: Asset.primaryButtonColor)!.pointImage(), for: .normal)
        setBackgroundImage(UIColor(asset: Asset.primaryButtonDisabledColor)!.pointImage(), for: .disabled)
        setBackgroundImage(UIColor(asset: Asset.primaryButtonTappedColor)!.pointImage(), for: .highlighted)
        setTitleColor(.white, for: .normal)
    }
}
