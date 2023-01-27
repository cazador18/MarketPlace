import Foundation

internal enum AdQueryType {
    case all
    case filterTitle
    case filterCategory
}

internal class AdQueryParameters {
    internal var queryType: AdQueryType
    internal var categoryId: Int?
    internal var text: String?
    
    internal init(queryType: AdQueryType, categoryId: Int, text: String) {
        self.queryType = queryType
        self.categoryId = categoryId
        self.text = text
    }
    
    internal init(queryType: AdQueryType) {
        self.queryType = queryType
    }
}
