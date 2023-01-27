import Foundation
import Swinject

internal final class ModulesAssembly: Assembly {
    internal func assemble(container: Container) {
        container.autoregister(
            RegistrationViewModelInput.self,
            initializer: RegistrationViewModel.init
        )
        
        container.autoregister(
            LoginViewModelInput.self,
            initializer: LoginViewModel.init
        )
        
        container.autoregister(
            OneTimePasswordViewModelInput.self,
            initializer: OneTimePasswordViewModel.init
        )

        container.autoregister(
            StartPageViewModelInput.self,
            initializer: StartPageViewModel.init
        )
        
        container.autoregister(
            MainViewModelInput.self,
            initializer: MainViewModelImpl.init
        )
        
        container.autoregister(
            MyProfileViewModelInput.self,
            initializer: MyProfileViewModel.init
        )

        container.autoregister(
            AdDetailsViewModelInput.self,
            initializer: AdDetailsViewModel.init)
        
        container.register(NetworkService.self) { _ in
            return .init(session: .init(configuration: .default))
        }
        
        container.autoregister(
            NewAdViewModelInput.self,
            initializer: NewAdViewModel.init
        )
        
        container.autoregister(
            FAQViewModelInput.self,
            initializer: FAQViewModel.init
        )
        
        container.autoregister(
            CategoryChooseViewModelInput.self,
            initializer: CategoryChooseViewModel.init
        )

        container.autoregister(
            EditAdViewModelInput.self,
            initializer: EditAdViewModel.init
        )
    }
}
