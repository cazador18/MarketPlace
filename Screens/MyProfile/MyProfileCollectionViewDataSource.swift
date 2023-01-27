import Foundation
import UIKit

internal final class MyProfileCollectionViewDataSource: NSObject {
    private var moderateAds: [MyAds] = []
    private var activeAds: [MyAds] = []
    private var nextPage: Int?
    private var stopLoading: (() -> Void)?
    private var shouldShowLoadIndicator: Bool {
        return nextPage != nil
    }
    private var isLoadingMoreAds = false

    internal var statusAds: Int = 0
    internal var selectMyAdAction: ((MyAds) -> Void)?
    internal var changePage: ((String, Int) -> Void)?
    internal func clean() {
        moderateAds = []
        activeAds = []
        nextPage = nil
    }
    internal func populateDataSource(ads: [MyAds], nextPage: Int?) {
        switch statusAds {
        case 0:
            activeAds += ads
        case 1:
            moderateAds += ads
        default:
            return
        }

        self.nextPage = nextPage
        isLoadingMoreAds = false
        stopLoading?()
    }
}

extension MyProfileCollectionViewDataSource: UICollectionViewDataSource {
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch statusAds {
        case 0:
            return activeAds.count
        case 1:
            return moderateAds.count
        default:
            return 0
        }
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyProfileUICollectionViewCell.identifier, for: indexPath) as! MyProfileUICollectionViewCell
        switch statusAds {
        case 0:
            cell.configure(activeAds[indexPath.row])
        case 1:
            cell.configure(moderateAds[indexPath.row])
        default:
            return UICollectionViewCell()
        }
        return cell
    }
}

extension MyProfileCollectionViewDataSource: UICollectionViewDelegate {
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch statusAds {
        case 0:
            let myad = activeAds[indexPath.row]
            selectMyAdAction?(myad)
        case 1:
            let myad = moderateAds[indexPath.row]
            selectMyAdAction?(myad)
        default:
            let myad = activeAds[indexPath.row]
            selectMyAdAction?(myad)
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension MyProfileCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    internal func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
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
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadIndicator,
                !activeAds.isEmpty && statusAds == 0 || !moderateAds.isEmpty && statusAds == 1 else { return .zero }
        return CGSize(width: collectionView.frame.width,
                      height: 60)
    }
}

// MARK: UIScrollViewDelegate
extension MyProfileCollectionViewDataSource: UIScrollViewDelegate {
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalFixedHeight = scrollView.frame.height

        guard shouldShowLoadIndicator, !isLoadingMoreAds else { return }
        if offset >= (totalContentHeight - totalFixedHeight) {
            isLoadingMoreAds = true
            if let nextPage = nextPage {
                let stringNextPage: String = .init(nextPage)
                changePage?(stringNextPage, statusAds)
            }
        }
    }
}
