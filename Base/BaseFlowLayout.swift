import UIKit.UICollectionViewFlowLayout

open class VerticalFlowLayout: UICollectionViewFlowLayout {
    public override init() {
        super.init()
        
        sectionInset = UIEdgeInsets(top: 5,
                                    left: 5,
                                    bottom: 5,
                                    right: 5)
        
        minimumInteritemSpacing = 5
        minimumLineSpacing = 5
        scrollDirection = .vertical
        
        let numberOfItems = 2
        
        let width = ((UIScreen.main.bounds.width
                      - sectionInset.left
                      - sectionInset.right
                      - minimumInteritemSpacing * CGFloat(numberOfItems - 1))
                     / CGFloat(numberOfItems)).rounded(.down)
        
        let height = width + 112
        
        itemSize = CGSize(width: width, height: height)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
