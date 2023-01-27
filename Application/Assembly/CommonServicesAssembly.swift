import Foundation
import Swinject
import SwinjectAutoregistration

public final class CommonServicesAssembly: Assembly {
    public func assemble(container: Container) {
        container.autoregister(
            KeychainServiceProtocol.self,
            initializer: KeychainService.init
        )
        
        container.autoregister(
            CategoryCollectionViewDataSource.self,
            initializer: CategoryCollectionViewDataSource.init
        )
        
        container.autoregister(
            AdCollectionViewDataSource.self,
            initializer: AdCollectionViewDataSource.init
        )
    }
}
