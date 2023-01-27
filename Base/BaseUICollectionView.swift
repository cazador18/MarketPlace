import UIKit.UICollectionView

open class BaseUICollectionView: UICollectionView {
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let verticalLayout: VerticalFlowLayout = .init()
        super.init(frame: frame, collectionViewLayout: verticalLayout)
        setupBaseUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBaseUI() {
        self.showsVerticalScrollIndicator = false
    }
}
