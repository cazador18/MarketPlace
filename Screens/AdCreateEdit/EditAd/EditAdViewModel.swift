import Foundation
import UIKit
import Kingfisher

internal protocol EditAdViewModelInput: UITextFieldDelegate {
    var coordinator: EditAdCoordinator? { get set }
    var adModel: MyAds? { get set }
    var output: EditAdViewModelOutput? { get set }
    var addImageDataSource: AddImageCollectionViewDataSource { get set }
    
    func loadImagesInAd()
    
    func addImageButtonTap()
    func chooseCategoryTypeButtonTap()
    func chooseDealTypeButtonTap()
    func chooseCurrencyTypeButtonTap()
    
    func viewDeleteAdButtonTap()
    func alertDeleteAdButtonTap()
    func alertOkButtonTap()
    func activateAdButtonTap()
    
    // MARK: - Value changed actions
    
    func titleTextFieldValueChanged(_ value: String?)
    func descriptionTextFieldValueChanged(_ value: String?)
    func contractPriceSwitchValueChanged(_ value: Bool?)
    func priceTextFieldValueChanged(_ value: String?)
    func oMoneySwitchValueChanged(_ value: Bool?)
    func writeToWhatsAppSwitchValueChanged(_ value: Bool?)
    func writeToTelegramSwitchValueChanged(_ value: Bool?)
}

internal protocol EditAdViewModelOutput {
    func categorySelected(_ category: Category?)
    func dealSelected(_ deal: String?)
    func currencySelected(_ currency: String?)
    func isActivateAdButtonEnabled(_ flag: Bool)
    func showAlert(message: String)
    func showSingleButtonAlert(title: String, message: String)
    func buttonPressedState()
    func disableButtonPressedState()
}

internal class EditAdViewModel: BaseViewModel<EditAdsRepositiryProtocol> {
    
    internal var output: EditAdViewModelOutput?
    internal var adModel: MyAds?
    internal var coordinator: EditAdCoordinator?
    internal var addImageDataSource: AddImageCollectionViewDataSource = .init()
    
    private var isValidTitle = true
    private var isValidDescription = true
    
    // MARK: - Changed fields
    
    private var changedTitle: String?
    private var changedCategoryId: Int?
    private var changedDescription: String?
    private var changedDealType: String?
    private var changedContractPrice: Bool?
    private var changedCurrency: String?
    private var changedPrice: String?
    private var changedOMoneyPay: Bool?
    private var changedWriteToWhatsApp: Bool?
    private var changedWhatsAppPhoneNumber: String?
    private var changedWriteToTelegram: Bool?
    private var changedTelegramUsername: String?
}

extension EditAdViewModel: EditAdViewModelInput {
    internal func chooseCategoryTypeButtonTap() {
        coordinator?.presentChooseCategoryType()
        coordinator?.selectedCategoryAction = categorySelected(_:)
    }
    
    internal func chooseDealTypeButtonTap() {
        coordinator?.presentChooseDealType()
        coordinator?.selectedDealAction = dealSelected(_:)
    }
    
    internal func chooseCurrencyTypeButtonTap() {
        coordinator?.presentChooseCurrencyType()
        coordinator?.selectedCurrencyAction = currencySelected(_:)
    }
    
    internal func addImageButtonTap() {
        coordinator?.chooseImageTypeAlert(dataSource: addImageDataSource)
    }
    
    internal func viewDeleteAdButtonTap() {
        output?.showAlert(message: "Вы уверенны что хотите удалить объявление?")
    }
    
    internal func alertDeleteAdButtonTap() {
        output?.buttonPressedState()
        guard let uuid = adModel?.uuid else { return }
        deleteAd(uuid: uuid)
    }
    
    internal func titleTextFieldValueChanged(_ value: String?) {
        if value?.count ?? 0 > 0 {
            isValidTitle = true
        } else {
            isValidTitle = false
        }
        
        self.changedTitle = value
        
        output?.isActivateAdButtonEnabled(isValidTitle && isValidDescription)
    }
    
    internal func descriptionTextFieldValueChanged(_ value: String?) {
        if value?.count ?? 0 > 1 {
            isValidDescription = true
        } else {
            isValidDescription = false
        }
        
        self.changedDescription = value
        
        output?.isActivateAdButtonEnabled(isValidTitle && isValidDescription)
    }
    
    internal func contractPriceSwitchValueChanged(_ value: Bool?) {
        self.changedContractPrice = value
    }
    
    internal func priceTextFieldValueChanged(_ value: String?) {
        self.changedPrice = value
    }
    
    internal func oMoneySwitchValueChanged(_ value: Bool?) {
        self.changedOMoneyPay = value
    }
    
    internal func writeToWhatsAppSwitchValueChanged(_ value: Bool?) {
        self.changedWriteToWhatsApp = value
    }
    
    internal func whatsAppPhoneNumberTextFieldValueChanged(_ value: String?) {
        self.changedWhatsAppPhoneNumber = value
    }
    
    internal func writeToTelegramSwitchValueChanged(_ value: Bool?) {
        self.changedWriteToTelegram = value
    }
    
    internal func telegramUsernameTextFieldValueChaned(_ value: String?) {
        self.changedTelegramUsername = value
    }
    
    internal func activateAdButtonTap() {
        output?.buttonPressedState()
        guard let adModel = adModel else { return }
        
        if addImageDataSource.addedImages.count > 0 {
            addImagesInAdd(adModel)
        } else {
            self.adModel?.minifyImages = nil
            if changedCategoryId != nil {
                fillChangedFields()
            } else if let categoryName = adModel.category?.name {
                searchCategoryAndEditAd(name: categoryName)
            }
        }
    }
    
    // swiftlint:disable all
    private func fillChangedFields() {
        
        if changedTitle != nil {
            adModel?.title = changedTitle
        }
        
        if changedDescription != nil {
            adModel?.description = changedDescription
        }
        
        if changedCategoryId != nil {
            adModel?.categoryID = changedCategoryId
        }
        
        if changedDealType != nil {
            if changedDealType == "Купить" {
                adModel?.adType = "buy"
            } else if changedDealType == "Продать" {
                adModel?.adType = "sell"
            }
        }
        
        if changedContractPrice != nil && changedContractPrice == true {
            adModel?.contractPrice = true
        } else if changedContractPrice != nil && changedContractPrice == false {
            adModel?.contractPrice = false
        }
        
        if changedCurrency != nil {
            if changedCurrency == "Сомы" {
                adModel?.currency = "som"
            } else if changedCurrency == "Доллары" {
                adModel?.currency = "usd"
            }
        }
        
        if changedPrice != nil {
            adModel?.price = changedPrice
        }
        
        if changedOMoneyPay != nil {
            adModel?.oMoneyPay = changedOMoneyPay
        }
        
        if changedWriteToWhatsApp != nil {
            if let number = changedWhatsAppPhoneNumber {
                let splitPhoneNumber = number.removingWhiteSpaces()
                let validPhoneNumber = String(splitPhoneNumber.dropFirst())
                adModel?.whatsapp = validPhoneNumber
            }
        }
        
        if changedWriteToTelegram != nil {
            if let username = changedTelegramUsername {
                let splitUsername = username.dropFirst(2)
                adModel?.telegram = String(splitUsername)
            }
        }
        
        if let model = adModel {
            editAd(model: model)
        }
    }
    // swiftlint:enable all
    
    internal func alertOkButtonTap() {
        output?.disableButtonPressedState()
        coordinator?.popViewController()
    }
    
    internal func loadImagesInAd() {
        guard adModel?.minifyImages?.count ?? 0 > 0 else { return }
        
        adModel?.minifyImages?.forEach { imageURL in
            guard let imageURL = URL(string: imageURL) else { return}
            KingfisherManager.shared.retrieveImage(with: imageURL) { [weak self] result in
                let image = try? result.get().image
                if let image = image {
                    self?.addImageDataSource.addedImages.append(image)
                    DispatchQueue.main.async { [weak self] in
                        self?.addImageDataSource.reloadData?()
                    }
                }
            }
        }
    }
    
    private func searchCategoryAndEditAd(name: String) {
        repository.searchCategory(name: name) { [weak self] result in
            switch result {
            case .success(let response):
                self?.changedCategoryId = response.results?.first?.id
                self?.fillChangedFields()
            case .failure:
                print("error searching cateogry by word")
            }
        }
    }
    
    private func editAd(model: MyAds) {
        guard let uuid = model.uuid else { return }
        repository.editAds(uuid: uuid, model: model) { [weak self] result in
            switch result {
            case .success(let response):
                if response.resultCode == "SUCCESS" {
                    DispatchQueue.main.async {
                        self?.output?.showSingleButtonAlert(title: "Успешно", message: "Объявление отправлено на модерацию")
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.output?.showSingleButtonAlert(title: "Ошибка", message: response.details?.values.first?[0] ?? "")
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func deleteAd(uuid: String) {
        repository.deleteAd(uuid: uuid) { [weak self] result in
            switch result {
            case .success(let response):
                if response.resultCode == "SUCCESS" {
                    DispatchQueue.main.async {
                        self?.output?.showSingleButtonAlert(title: "Успешно", message: "Объявление было успешно удалено")
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func addImagesInAdd(_ model: MyAds) {
        guard let uuid = model.uuid else { return }
        guard addImageDataSource.addedImages.count > 0 else {
            return
        }
        
        _ = model
        var imagesURLArray: [String] = []
        
        let imagesUploadingQueue = DispatchQueue(label: "imagesUploading")
        let imagesUploadingGroup = DispatchGroup()
        
        if addImageDataSource.addedImages.count > 0 {
            imagesUploadingQueue.async { [weak self] in
                self?.addImageDataSource.addedImages.reversed().forEach { image in
                    if let imageData = image.jpegData(compressionQuality: 0.5) {
                        imagesUploadingGroup.enter()
                        self?.repository.postImageInAd(adUUID: uuid, image: imageData) { result in
                            switch result {
                            case .success(let response):
                                if response.resultCode == "SUCCESS" {
                                    if let url = response.result?.values.first {
                                        imagesURLArray.append(url)
                                    }
                                }
                                imagesUploadingGroup.leave()
                            case .failure(let error):
                                print("error loading images", error.localizedDescription)
                            }
                        }
                        _ = imagesUploadingGroup.wait(timeout: .distantFuture)
                    }
                }
                
                imagesUploadingGroup.notify(queue: .global()) { [weak self] in
                    self?.adModel?.minifyImages = imagesURLArray
                    if self?.changedCategoryId != nil {
                        self?.fillChangedFields()
                    } else if let categoryName = self?.adModel?.category?.name {
                        self?.searchCategoryAndEditAd(name: categoryName)
                    }
                    return
                }
            }
        }
    }
}


extension EditAdViewModel {
    internal func categorySelected(_ category: Category?) {
        self.changedCategoryId = category?.id
        output?.categorySelected(category)
    }
    
    internal func dealSelected(_ deal: String?) {
        self.changedDealType = deal
        output?.dealSelected(deal)
    }
    
    internal func currencySelected(_ currency: String?) {
        self.changedCurrency = currency
        output?.currencySelected(currency)
    }
}

// MARK: Whatsapp/Telegram textFields validation

extension EditAdViewModel {
    private func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        for char in mask where index < numbers.endIndex {
            if char == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
}

extension EditAdViewModel: UITextFieldDelegate {
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // whatsAppPhoneNumberCell textField
        if textField.tag == 0 {
            guard (5..<16).contains(range.location), let text = textField.text else { return false }
            
            if range.location == 5 && string == "" {
                return true
            }
            
            if range.location == 16 {
                self.changedWhatsAppPhoneNumber = textField.text
            }
            
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = format(with: "+XXX XXX XXX XXX", phone: newString)
            return false
            // telegramUsernameCell textField
        } else if textField.tag == 1 {
            guard (2...32).contains(range.location) else { return false }
            
            if range.location > 5 {
                self.changedTelegramUsername = textField.text
            }
            
            return true
        }
        
        return false
    }
    
    internal func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            textField.text = "+996 "
        } else if textField.tag == 1 {
            textField.text = "@ "
        }
        
        return false
    }
}
