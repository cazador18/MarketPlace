import UIKit

// MARK: UICollectionViewDataSource
final internal class AdCollectionViewDataSource: NSObject,
                                                 UICollectionViewDataSource {
    // MARK: Properties
    private var ads: [AdElement]?
    private var lastContentOffset: CGFloat = 0
    private var nextPage: Int?
    private var countAds: Int?
    private var shouldShowLoadIndicator: Bool {
        return nextPage != nil
    }
    private var isLoadingMoreAds = false
    private var isHide: Bool = false {
        didSet {
            hideViews?(isHide)
        }
    }
    
    private var stopLoading: (() -> Void)?
    internal var selectAction: ((String) -> Void)?
    internal var changePage: ((String) -> Void)?
    internal var hideViews: ((Bool) -> Void)?
    
    // MARK: Internal Methods
    internal func setModel(model: AdResult) {
        if var loadedAds = ads,
           let elements = model.results {
            loadedAds += elements
            ads = loadedAds
        } else {
            ads = model.results
        }

        countAds = model.count
        nextPage = model.next
        isLoadingMoreAds = false
        stopLoading?()
    }
    
    internal func clean() {
        if isHide {
            isHide = false
        }
        
        lastContentOffset = 0
        ads = nil
        countAds = nil
        nextPage = nil
    }
    
    internal func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        guard let ads = ads, !ads.isEmpty else {
            collectionView.backgroundView = EmptyView()
            return 0
        }
        collectionView.backgroundView = nil
        return ads.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdCollectionViewCell.identifier,
                                                      for: indexPath) as! AdCollectionViewCell

        if let adElement = ads?[indexPath.item] {
            cell.configure(adElement)
        }

        return cell
    }
}

// MARK: UICollectionViewDelegate
extension AdCollectionViewDataSource: UICollectionViewDelegate {
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let adElement = ads?[indexPath.item],
           let uuId = adElement.uuid {
            selectAction?(uuId)
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension AdCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    internal func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderCollectionReusableView.identifier,
                for: indexPath) as! HeaderCollectionReusableView
            
            return header
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FooterCollectionReusableView.identifier,
                for: indexPath) as! FooterCollectionReusableView
            footer.startAnimating()
            stopLoading = footer.stopAnimating
            return footer
        default:
            return UICollectionReusableView()
        }
    }

    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width,
                      height: 56)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadIndicator, ads != nil else { return .zero }
        return CGSize(width: collectionView.frame.width,
                      height: 60)
    }
}

// MARK: UIScrollViewDelegate
extension AdCollectionViewDataSource: UIScrollViewDelegate {
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalFixedHeight = scrollView.frame.height

        if lastContentOffset > offset && lastContentOffset < totalContentHeight - totalFixedHeight, isHide {
            isHide = false
        } else if lastContentOffset < offset && offset > 200, !isHide {
            isHide = true
        }
        lastContentOffset = offset

        guard shouldShowLoadIndicator, !isLoadingMoreAds else { return }
        if offset >= (totalContentHeight - totalFixedHeight) {
            isLoadingMoreAds = true
            if let nextPage = nextPage {
                let stringNextPage: String = .init(nextPage)
                changePage?(stringNextPage)
            }
        }
    }
}
