import UIKit
import PhotosUI

internal final class AddImageCollectionViewDataSource: NSObject {
    internal var addedImages: [UIImage] = []
    
    internal var handleAddImageButtonAction: (() -> Void)?
    internal var reloadData: (() -> Void)?
    internal var handleDeleteImageButtonAction: (() -> Void)?
    
    private func removeImage(_ index: Int) {
        addedImages.remove(at: index - 1)
        reloadData?()
    }
}

// MARK: UIImagePickerControllerDelegate

extension AddImageCollectionViewDataSource: UIImagePickerControllerDelegate {
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            addedImages.append(image.resizedImageForNetworkTransmission())
            reloadData?()
        }
        picker.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.presentingViewController?.dismiss(animated: true)
    }
}

// MARK: PHPickerViewControllerDelegate 

extension AddImageCollectionViewDataSource: PHPickerViewControllerDelegate {
    internal func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard results.count > 0 else { return }
        
        let imagesQueue = DispatchQueue(label: "imagesQueue")
        let imagesDispatchGroup = DispatchGroup()
        
        imagesQueue.async {
            for pickerResult in results {
                imagesDispatchGroup.enter()
                pickerResult.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                    guard let self = self else { return }
                    if let image = image as? UIImage {
                        self.addedImages.append(image.resizedImageForNetworkTransmission())
                        imagesDispatchGroup.leave()
                    }
                }
                _ = imagesDispatchGroup.wait(timeout: .distantFuture)
            }
            
            imagesDispatchGroup.notify(queue: .main) { [weak self] in
                guard let self = self else { return }
                self.reloadData?()
            }
        }
    }
}

// MARK: - UINavigationControllerDelegate

extension AddImageCollectionViewDataSource: UINavigationControllerDelegate {}

// MARK: - UICollectionViewDataSource

extension AddImageCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addedImages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddImageButtonCollectionViewCell.identifier, for: indexPath) as! AddImageButtonCollectionViewCell
            cell.addImageButtonAction = handleAddImageButtonAction
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainImageCollectionViewCell.identifier, for: indexPath) as! MainImageCollectionViewCell
            let image = addedImages[indexPath.item - 1]
            cell.indexItem = indexPath.item
            cell.didTapDeleteImage = removeImage(_:)
            cell.setup(image)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
            let image = addedImages[indexPath.item - 1]
            cell.indexItem = indexPath.item
            cell.didTapDeleteImage = removeImage(_:)
            cell.setup(image)
            return cell
        }
    }
}
