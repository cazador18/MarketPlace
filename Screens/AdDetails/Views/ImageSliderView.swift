import Foundation
import UIKit
import Kingfisher

internal protocol ImageSliderViewDelegate: AnyObject {
    func imageSliderView(_ imageSliderView: ImageSliderView, didSwipeToImageAt index: Int)
    func imageSliderViewDidTap(_ imagesliderView: ImageSliderView)
}

internal class ImageSliderView: UIView {

    internal var imageUrls: [URL] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    internal var visibleImageIndex: Int? {
        get {
            let center = collectionView.convert(
                CGPoint(x: collectionView.frame.midX,
                        y: collectionView.frame.midY),
                from: collectionView.superview)
            if let cellAtCenter = collectionView.visibleCells.first(where: {
                $0.frame.contains(center)
            }) {
                return self.collectionView.indexPath(for: cellAtCenter)?.item
            }
            return nil

        }
        set {
            if let item = newValue {
                collectionView.scrollToItem(
                    at: IndexPath(item: item, section: 0),
                    at: .centeredHorizontally,
                    animated: false)
            }
        }
    }

    internal weak var delegate: ImageSliderViewDelegate?

    internal var zoomEnabled = false {
        didSet {
            (collectionView.visibleCells as? [ImageSliderViewCell])?.forEach { cell in
                cell.zoomEnabled = self.zoomEnabled
            }
        }
    }

    private lazy var collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(ImageSliderViewCell.self, forCellWithReuseIdentifier: "ImageSliderViewCell")

        return collectionView
    }()

    internal override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(collectionView)
        collectionView.backgroundColor = .clear

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        collectionView.addGestureRecognizer(gesture)
    }

    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        delegate?.imageSliderViewDidTap(self)
    }
}

extension ImageSliderView: UIScrollViewDelegate {

    internal func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let visibleImageIndex = visibleImageIndex {
            delegate?.imageSliderView(self, didSwipeToImageAt: visibleImageIndex)
        }
    }
}

extension ImageSliderView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }

    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ImageSliderViewCell",
            for: indexPath) as! ImageSliderViewCell
        cell.imageUrl = imageUrls[indexPath.item]
        cell.zoomEnabled = self.zoomEnabled
        return cell
    }

    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.bounds.size
    }
}
