import UIKit

internal class ModalTypeSelectionView: BaseView {
    internal let titleLabel: UILabel = .init()
    internal let actionsTableView: UITableView = .init(frame: .zero, style: .insetGrouped)
    internal let closeButton: UIButton = .init()
    internal let contentView: UIView = .init()
    internal let grayView: UIView = .init()
    
    // MARK: Constants
    
    private let maxGrayViewAlpha: CGFloat = 0.6
    private let contentViewHeight: CGFloat = 216
    private let contentViewdismissibleHeight: CGFloat = 200
    private var contentViewBottomConstraint: NSLayoutConstraint?
    private var contentViewHeightConstraint: NSLayoutConstraint?
    
    // MARK: Actions
    
    internal var dismissAction: (() -> Void)?
    
    // MARK: DataSource
    
//    internal var modalTypeSelectionDataSource: [String] = []
    
    // MARK: - Lifecycle
    
    internal override func onConfigureView() {
        actionsTableView.tableHeaderView = UIView(frame: CGRect(x: .zero, y: .zero, width: .zero, height: CGFloat.leastNonzeroMagnitude))
        actionsTableView.layoutMargins = .init(top: 0, left: 5, bottom: 0, right: 5)
//        actionsTableView.delegate = self
//        actionsTableView.dataSource = self
        
        titleLabel.font = UIFont(font: FontFamily.SFProText.regular, size: 17)
        titleLabel.text = "Тип сделки"
        
        closeButton.setImage(Asset.closeButton.image, for: .normal)
        closeButton.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        
        contentView.backgroundColor = .systemGroupedBackground
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
        
        grayView.backgroundColor = .black
        grayView.alpha = maxGrayViewAlpha
    }
    
    internal override func onAddSubViews() {
        addSubview(grayView)
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(actionsTableView)
        contentView.addSubview(closeButton)
    }
    
    internal override func onSetUpConstraints() {
        grayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        contentViewHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: contentViewHeight)
        contentViewHeightConstraint?.isActive = true
        
        contentViewBottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: contentViewHeight)
        contentViewBottomConstraint?.isActive = true
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(50)
            $0.leading.equalTo(contentView.snp.leading).offset(16)
        }
        
        actionsTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(contentView.snp.leading)
            $0.trailing.equalTo(contentView.snp.trailing)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(8)
            $0.trailing.equalTo(contentView.snp.trailing).inset(8)
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
    }
    
    // MARK: - Internal methods
    
    internal func animateShowGrayView() {
        grayView.alpha = 0
        UIView.animate(withDuration: 0.4) { [weak self] in
            guard let self = self else { return }
            self.grayView.alpha = self.maxGrayViewAlpha
        }
    }
    
    internal func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {[weak self] in
            guard let self = self else { return }

            self.contentViewBottomConstraint?.constant = 0
            self.layoutIfNeeded()
        }
    }
    
    internal func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCloseAction))
        grayView.addGestureRecognizer(tapGesture)
    }
    
    
    internal func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        addGestureRecognizer(panGesture)
    }
    
    @objc internal func handleCloseAction() {
        animateDismissGrayView()
    }
    
    // MARK: - Private methods
    
    internal func animateDismissGrayView() {
        UIView.animate(withDuration: 0.4) {
            self.grayView.alpha = 0
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.dismissAction?()
        }
        
        contentViewBottomConstraint?.isActive = false
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(contentViewHeight)
            $0.height.equalTo(216)
        }
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.layoutIfNeeded()
        }
    }
    
    /* Hide by swipe down */
    
    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        let newHeight = contentViewHeight - translation.y
        
        switch gesture.state {
        case .changed:
            if newHeight < contentViewHeight {
                contentViewHeightConstraint?.constant = newHeight
                layoutIfNeeded()
            }
        case .ended:
            if newHeight < contentViewdismissibleHeight {
                self.animateDismissGrayView()
            }
        default:
            break
        }
    }
    
    @objc private func closeScreen() {
        animateDismissGrayView()
    }
}
