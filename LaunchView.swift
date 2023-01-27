import UIKit
import SnapKit
class LaunchView: UIView {
    let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(asset: Asset.oMarketLogo)
        return imageview
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        appearAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(imageView)
        backgroundColor = .white
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(122)
            make.height.equalTo(22)
        }
    }
    private func appearAnimation() {
            UIView.animate(withDuration: 1.0) { [weak self] in
                self?.imageView.alpha = 1
            } completion: { [weak self] _ in
                self?.disappearLaunchView()
            }
        }

        private func disappearLaunchView() {
            UIView.animate(withDuration: 1.0) { [weak self] in
                self?.imageView.alpha = 0
            } completion: { [weak self] _ in
                self?.removeFromSuperview()
            }
        }
    
}
