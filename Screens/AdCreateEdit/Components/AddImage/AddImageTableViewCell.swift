import UIKit

internal final class AddImageTableViewCell: BaseUITableViewCell {
    
    internal let addImageCollectionView: AddImageCollectionView = .init()
    
    internal override func onConfigureCell() {
        addImageCollectionView.showsHorizontalScrollIndicator = false
        
        addImageCollectionView.register(AddImageButtonCollectionViewCell.self, forCellWithReuseIdentifier: AddImageButtonCollectionViewCell.identifier)
        addImageCollectionView.register(MainImageCollectionViewCell.self, forCellWithReuseIdentifier: MainImageCollectionViewCell.identifier)
        addImageCollectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }
    
    internal override func onAddSubviews() {
        contentView.addSubview(addImageCollectionView)
    }
    
    internal override func onSetUpConstraints() {
        addImageCollectionView.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.edges)
        }
    }
}
