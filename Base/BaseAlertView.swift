import UIKit
import SnapKit

public class BaseAlertView: UIView {
    public var firstButtonAction: (() -> Void)?
    public var secondButtonAction: (() -> Void)?
    public var cancelButtonAction: (() -> Void)?
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Тип сделки"
        label.font = FontFamily.SFProText.regular.font(size: 17)
        return label
    }()
    private let button1: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.setTitle("Куплю", for: .normal)
        button.titleLabel?.font = FontFamily.SFProText.regular.font(size: 17)
        button.layer.cornerRadius = 8
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    private let button2: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = FontFamily.SFProText.regular.font(size: 17)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("Продаю", for: .normal)
        return button
    }()
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(asset: Asset.closeButton), for: .normal)
        button.layer.cornerRadius = 52 / 2
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setupUI()
        backgroundColor = UIColor(asset: Asset.backgroundColor)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        addSubview(titleLabel)
        addSubview(button1)
        addSubview(button2)
        addSubview(cancelButton)
    }
    
    public func updateTitlelabel(text: String) {
        titleLabel.text = text
    }
    public func updateFirstButtonText(text: String) {
        button1.setTitle(text, for: .normal)
    }
    public func updateSecondButtonText(text: String) {
        button2.setTitle(text, for: .normal)
    }
    private func setupTargets() {
        button1.addTarget(self, action: #selector(firstButtonTapped), for: .touchUpInside)
        button2.addTarget(self, action: #selector(secondButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    private func setupUI() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(25)
            $0.leading.equalTo(snp.leading).offset(16)
        }
        button1.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.leading.equalTo(snp.leading).offset(8)
            $0.height.equalTo(44)
            $0.trailing.equalTo(snp.trailing).offset(-8)
        }
        button2.snp.makeConstraints {
            $0.top.equalTo(button1.snp.bottom).offset(2)
            $0.leading.equalTo(snp.leading).offset(8)
            $0.height.equalTo(44)
            $0.trailing.equalTo(snp.trailing).offset(-8)
        }
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(snp.top).offset(6)
            $0.trailing.equalTo(snp.trailing).offset(-6)
            $0.width.equalTo(52)
            $0.height.equalTo(52)
        }
    }
}
extension BaseAlertView {
    @objc private func firstButtonTapped() {
        firstButtonAction?()
    }
    @objc private func secondButtonTapped() {
        secondButtonAction?()
    }
    @objc private func cancelButtonTapped() {
        cancelButtonAction?()
    }
 }
