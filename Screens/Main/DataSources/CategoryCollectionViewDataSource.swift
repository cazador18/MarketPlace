import UIKit

// MARK: UICollectionViewDataSource
final internal class CategoryCollectionViewDataSource: NSObject,
                                UICollectionViewDataSource {
    // MARK: Properties
    private var model: ResultCategory?
    internal var selectCategoryAction: ((Int) -> Void)?
    // MARK: Internal Methods
    internal func setModel(model: ResultCategory) {
        self.model = model
    }
    
    internal func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
    
        guard let count = model?.result?.count else { return 0 }
        return count
    }
    
    internal func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier,
                                                      for: indexPath) as! CategoryCollectionViewCell
        guard indexPath.item != 0 else {
            cell.configureAllCategoryCell()
            return cell
        }
        
        if let category = model?.result?[indexPath.item - 1],
           let categoryName =  category.name,
           let categoryIconImg =  category.iconImg {
            cell.configureCell(title: categoryName,
                               imageUrl: categoryIconImg)
        }
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension CategoryCollectionViewDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            selectCategoryAction?(0)
        default:
            if let category = model?.result?[indexPath.item - 1],
                let categoryId = category.id {
                selectCategoryAction?(categoryId)
            }
        }
    }
}
