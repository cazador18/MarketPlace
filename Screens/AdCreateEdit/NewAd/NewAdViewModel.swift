import Foundation
import UIKit

internal protocol NewAdViewModelInput: UITextFieldDelegate {
    var coordinator: NewAdsCoordinator? { get set }
    var output: NewAdViewModelOutput? { get set }
    var addImageDataSource: AddImageCollectionViewDataSource { get set }
    
    // MARK: - Button Actions
    
    func addImageButtonTap()
    func chooseCategoryTypeButtonTap()
    func chooseDealTypeButtonTap()
    func chooseCurrencyTypeButtonTap()
    func alertOkButtonTap()
    
    func titleTextFieldValueChanged(_ value: String?)
    func descriptionTextFieldValueChanged(_ value: String?)
    func submitAddButtonTap(_ model: NewAdBodyModel)
}

internal protocol NewAdViewModelOutput {
    func categorySelected(_ category: Category?)
    func dealSelected(_ deal: String?)
    func currencySelected(_ currency: String?)
    func isSubmitButtonEnabled(_ flag: Bool)
    func showAlert(_ title: String, message: String)
    func showDismissAlert(_ title: String, message: String)
    func newAdButtonPressedState()
}

internal final class NewAdViewModel: BaseViewModel<NewAdsRepositiryProtocol> {
    internal var coordinator: NewAdsCoordinator?
    internal var output: NewAdViewModelOutput?
    internal var addImageDataSource: AddImageCollectionViewDataSource = .init()
    
    private var isValidTitle = false
    private var isValidDescription = false
    private var adUUID: String?
    
    private var selectedCategoryId: Int?
    private var selectedDeal: String?
    private var selectedCurrency: String?
}

// MARK: - NewAdViewModelInput

extension NewAdViewModel: NewAdViewModelInput {
    internal func titleTextFieldValueChanged(_ value: String?) {
        if value?.count ?? 0 > 0 {
            isValidTitle = true
        } else {
            isValidTitle = false
        }
        
        output?.isSubmitButtonEnabled(isValidTitle && isValidDescription)
    }
    
    internal func descriptionTextFieldValueChanged(_ value: String?) {
        if value?.count ?? 0 > 1 {
            isValidDescription = true
        } else {
            isValidDescription = false
        }
        
        output?.isSubmitButtonEnabled(isValidTitle && isValidDescription)
    }
    
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
    
    internal func submitAddButtonTap(_ model: NewAdBodyModel) {
        output?.newAdButtonPressedState()
        
        repository.newAdUUID { [weak self] result in
            switch result {
            case .success(let adUUID):
                self?.adUUID = adUUID.result
                self?.addImagesInAdd(model)
            case .failure(let error):
                print("Ad UUID creating error \(error.localizedDescription)")
            }
        }
    }
    
    internal func alertOkButtonTap() {
        coordinator?.popViewController()
    }
    
    private func addImagesInAdd(_ model: NewAdBodyModel) {
        guard let adUUID = adUUID else { return }
        guard addImageDataSource.addedImages.count > 0 else {
            fillFields(model)
            return
        }
        
        var model = model
        var imagesURLArray: [String] = []
        
        let imagesUploadingQueue = DispatchQueue(label: "imagesUploading")
        let imagesUploadingGroup = DispatchGroup()
        
        if addImageDataSource.addedImages.count > 0 {
            imagesUploadingQueue.async { [weak self] in
                self?.addImageDataSource.addedImages.forEach { image in
                    if let imageData = image.jpegData(compressionQuality: 0.5) {
                        imagesUploadingGroup.enter()
                        self?.repository.postImageInAd(adUUID: adUUID, image: imageData) { result in
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
                    model.images = imagesURLArray
                    self?.fillFields(model)
                    return
                }
            }
        }
    }
    // swiftlint:disable all
    private func fillFields(_ model: NewAdBodyModel) {
        var model = model
        
        if selectedCategoryId != nil {
            model.category = selectedCategoryId
        }
        
        if selectedDeal != nil {
            if selectedDeal == "Купить" {
                model.adType = "buy"
            } else if selectedDeal == "Продать" {
                model.adType = "sell"
            }
        }
        
        if model.contractPrice != nil && model.contractPrice == true {
        } else {
            model.contractPrice = false
            if model.price != nil, model.price?.count ?? 0 > 0 {
            }
            
            if selectedCurrency == "Сомы" {
                model.currency = "som"
            } else if selectedCurrency == "Доллары" {
                model.currency = "usd"
            }
        }
        
        
        if model.oMoneyPay != nil && model.oMoneyPay == true {
            model.oMoneyPay = true
        } else {
            model.oMoneyPay = false
        }
        
        if model.isWhatsAppEnabled != nil && model.isWhatsAppEnabled == true {
            if model.whatsAppPhoneNumber != nil {
                if let splitPhoneNumber = model.whatsAppPhoneNumber?.removingWhiteSpaces() {
                    let validPhoneNumber = String(splitPhoneNumber.dropFirst())
                    model.whatsAppPhoneNumber = validPhoneNumber
                }
            } else {
                model.isWhatsAppEnabled = false
            }
        } else {
            model.isWhatsAppEnabled = false
        }
        
        if model.isTelegramEnabled != nil && model.isTelegramEnabled == true {
            if model.telegramUsername != nil {
                if let splitUsername = model.telegramUsername?.dropFirst(2) {
                    model.telegramUsername = String(splitUsername)
                }
            }
        } else {
            model.isTelegramEnabled = false
        }
        
        submitAd(model)
    }
    // swiftlint:enable all
    
    private func submitAd(_ model: NewAdBodyModel) {
        guard let adUUID = adUUID else { return }
        repository.putBodyInAd(adUUID: adUUID, model: model) { [weak self] result in
            switch result {
            case .success(let response):
                if response.resultCode == "FAIL" {
                    DispatchQueue.main.async {
                        self?.output?.showAlert("Ошибка", message: response.details?.values.first?[0] ?? "Неизвестная ошибка")
                    }
                } else if response.resultCode == "SUCCESS" {
                    DispatchQueue.main.async {
                        self?.output?.showDismissAlert("Успешно", message: "Объявление было создано успешно")
                    }
                }
            case .failure(let error):
                print("Ad updating error \(error.localizedDescription)")
            }
        }
    }
    
}

// MARK: ModalAlert Output

extension NewAdViewModel {
    func categorySelected(_ category: Category?) {
        self.selectedCategoryId = category?.id
        output?.categorySelected(category)
    }
    
    internal func dealSelected(_ deal: String?) {
        self.selectedDeal = deal
        output?.dealSelected(deal)
    }
    
    internal func currencySelected(_ currency: String?) {
        self.selectedCurrency = currency
        output?.currencySelected(currency)
    }
}

// MARK: Whatsapp/Telegram textFields validation

extension NewAdViewModel {
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

extension NewAdViewModel: UITextFieldDelegate {
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // whatsAppPhoneNumberCell textField
        if textField.tag == 0 {
            guard (5..<16).contains(range.location), let text = textField.text else { return false }
            
            if range.location == 5 && string == "" {
                return true
            }
            
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = format(with: "+XXX XXX XXX XXX", phone: newString)
            return false
        // telegramUsernameCell textField
        } else if textField.tag == 1 {
            guard (2...32).contains(range.location) else { return false }
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
