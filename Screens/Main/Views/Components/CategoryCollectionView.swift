import UIKit

internal final class CategoryCollectionView: UICollectionView {
    
    // MARK: Initializers
    internal override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let horizontalLayout: HorizontalFlowLayout = .init()
        super.init(frame: frame, collectionViewLayout: horizontalLayout)
        setupBaseUI()
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    private func setupBaseUI() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
}

internal final class HorizontalFlowLayout: UICollectionViewFlowLayout {
    // MARK: Initializers
    internal override init() {
        super.init()
        
        sectionInset = UIEdgeInsets(top: 0,
                                    left: 0,
                                    bottom: 0,
                                    right: 0)
        
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .horizontal
        
        itemSize = CGSize(width: 68, height: 53)
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
