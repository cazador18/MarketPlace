import UIKit.UICollectionViewFlowLayout

internal final class AddImageCollectionViewLayout: UICollectionViewFlowLayout {
    internal override init() {
        super.init()
        
        scrollDirection = .horizontal
        sectionInset = UIEdgeInsets(top: 0,
                                    left: 8,
                                    bottom: 0,
                                    right: 0)
        minimumInteritemSpacing = 8
        minimumLineSpacing = 8
        
        itemSize = CGSize(width: 100, height: 100)
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
