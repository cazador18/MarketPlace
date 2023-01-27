import Foundation
import Swinject


public protocol BaseViewModelProtocol: AnyObject { }

open class BaseViewModel<Repository>: NSObject {
    open var repository: Repository = Swinjectable.container.resolve(Repository.self)!
}
