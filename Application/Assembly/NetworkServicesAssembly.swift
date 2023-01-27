import Foundation
import Swinject
import SwinjectAutoregistration

public final class NetworkServicesAssembly: Assembly {
    public func assemble(container: Container) {
        container.autoregister(
            LoginRepositoryProtocol.self,
            initializer: LoginRepository.init
        )
        
        container.autoregister(
            RegistrationRepositoryProtocol.self,
            initializer: RegistrationRepository.init
        )
        
        container.autoregister(
            OneTimePasswordRepositoryProtocol.self,
            initializer: OneTimePasswordRepository.init
        )
        container.autoregister(
            AccessTokenProviderProtocol.self,
            initializer: AccessTokenProvider.init
        )
        
        container.autoregister(
            MyProfileRepositoryProtocol.self,
            initializer: MyProfileRepository.init
        )

        container.autoregister(
            MainRepositoryProtocol.self,
            initializer: MainRepository.init
        )
        
        container.autoregister(
            FAQRepositoryProtocol.self,
            initializer: FAQRepository.init
        )
        container.autoregister(
            NewAdsRepositiryProtocol.self,
            initializer: NewAdsRepository.init
        )
        container.autoregister(
            EditAdsRepositiryProtocol.self,
            initializer: EditAdsRepository.init
        )
        container.autoregister(
            DeleteAdsRepositoryProtocol.self,
            initializer: DeleteAdsRepository.init
        )
        container.autoregister(
            AdDetailsRepositoryProtocol.self,
            initializer: AdDetailsRepository.init
        )
        container.autoregister(
            EditAdsRepositiryProtocol.self,
            initializer: EditAdsRepository.init
        )
        container.autoregister(
            NetworkManagerProtocol.self,
            initializer: NetworkManager.init
        )
    }
}
