import Foundation
import UIKit

enum AdDetailsMessagingMethod {
    case whatsapp(action: () -> Void)
    case telegram(action: () -> Void)
}

internal protocol AdDetailsViewModelInput {
    var coordinator: MainCoordinator? { get set }
    var output: AdDetailsViewModelOutput? { get set }

    var adUuid: String! { get set }
    var sections: [AdDetailsSection] { get }
    var fullImageUrls: [URL] { get }
    var messagingMethods: [AdDetailsMessagingMethod] { get }
    func call()

    func fetchData(_ completion: @escaping (Error?) -> Void)
}

internal protocol AdDetailsViewModelOutput {

}
internal class AdDetailsViewModel: BaseViewModel<AdDetailsRepositoryProtocol> {
    internal var coordinator: MainCoordinator?
    internal var output: AdDetailsViewModelOutput?

    internal var sections: [AdDetailsSection] = []

    internal var fullImageUrls: [URL] = []

    internal var messagingMethods: [AdDetailsMessagingMethod] = []

    internal var adUuid: String! = ""

    private var phoneUrl: URL?
}

extension AdDetailsViewModel: AdDetailsViewModelInput {


    func fetchData(_ completion: @escaping (Error?) -> Void) {
        repository.getAdDetails(uuid: adUuid) { [weak self] result in
            switch result {
            case .success(let model):
                self?.sections = model.toSections()
                self?.messagingMethods = model.toMessagingMethods()
                self?.fullImageUrls = model.images ?? []
                if let msisdn = model.author?.msisdn {
                    self?.phoneUrl = URL(string: "tel://\(msisdn)")
                }
                DispatchQueue.main.async {
                    completion(nil)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(error)
                }
            }
        }
    }

    func call() {
        if let phoneUrl = phoneUrl {
            UIApplication.shared.open(phoneUrl)
        }
    }
}

private extension AdDetails {

    func toSections() -> [AdDetailsSection] {
        var sections = [AdDetailsSection]()
        sections.append(AdDetailsSection(rows: [
            .images(AdDetailsImagesCellData(images: minifyImages ?? [],
                                            isVerified: isVerified ?? false))
        ]))
        if let title = title {
            sections.append(AdDetailsSection(rows: [
                .description(AdDetailsDescriptionCellData(title: title,
                                                          description: description ?? " "))
            ]))
        }
        if let priceString = price,
           let price = Double(priceString),
           let currency = currency?.toCurrency(),
           let authorName = author?.username {
            sections.append(AdDetailsSection(rows: [
                .priceAndAuthor(AdDetailsPriceAndAuthorCellData(
                    price: price,
                    currency: currency,
                    acceptsOMoney: oMoneyPay ?? false,
                    isVerifiedNumber: isVerified ?? false,
                    authorName: authorName))
            ]))
        }
        var keyValueRows = [AdDetailsRow]()
        if let category = category?.name {
            keyValueRows.append(.keyValue(AdDetailsKeyValueCellData(key: "Категория", value: category)))
        }
        if let publishedDate = publishedDate?.toString() {
            keyValueRows.append(.keyValue(AdDetailsKeyValueCellData(key: "Дата публикации", value: publishedDate)))
        }
        if let adType = adType, !adType.isEmpty {
            let localizedString = adType.localizedString()
            keyValueRows.append(.keyValue(AdDetailsKeyValueCellData(key: "Тип сделки", value: localizedString)))
        }
        if let location = location?.name {
            keyValueRows.append(.keyValue(AdDetailsKeyValueCellData(key: "Город", value: location)))
        }

        if !keyValueRows.isEmpty {
            sections.append(AdDetailsSection(rows: keyValueRows))
        }

        if let address = address, !address.isEmpty {
            sections.append(AdDetailsSection(rows: [
                .address(AdDetailsAddressCellData(address: address))
            ]))
        }
        return sections
    }

    func toMessagingMethods() -> [AdDetailsMessagingMethod] {
        var messagingMethods = [AdDetailsMessagingMethod]()
        if let whatsappNum = whatsappNum?.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression),
           let url = URL(string: "https://wa.me/\(whatsappNum)") {
            messagingMethods.append(.whatsapp(action: {
                UIApplication.shared.open(url)
            }))
        }
        if let telegramProfile = telegramProfile,
           let url = URL(string: "https://t.me:/\(telegramProfile)") {
            messagingMethods.append(.telegram(action: {
                UIApplication.shared.open(url)
            }))
        }
        return messagingMethods
    }
}

private extension String {
    func toCurrency() -> AdDetailsPriceAndAuthorCellData.Currency? {
        switch self {
        case "som":
            return .kgs
        case "usd":
            return .usd
        default:
            return nil
        }
    }
}

private extension String {
    func localizedString() -> String {
        switch self {
        case "sell":
            return "продажа"
        case "buy":
            return "купля"
        case "rent":
            return "аренда"
        case "service":
            return "услуга"
        default:
            return self
        }
    }
}

private extension Date {
    func toString() -> String {
        return Date.dateFormatter.string(from: self)
    }

    static let dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        return dateFormatter
    }()
}
