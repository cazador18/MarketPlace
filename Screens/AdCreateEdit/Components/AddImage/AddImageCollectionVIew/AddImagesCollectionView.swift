import UIKit.UICollectionView

internal final class AddImageCollectionView: UICollectionView {
    internal override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let horizontalLayout: AddImageCollectionViewLayout = .init()
        super.init(frame: frame, collectionViewLayout: horizontalLayout)
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
