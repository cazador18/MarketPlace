import UIKit
import IQKeyboardManagerSwift

@main
internal final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    internal var window: UIWindow?
    internal var coordinator: AppCoordinator?
    private lazy var services: [UIApplicationDelegate] = [
        SwinjectServices()
    ]
    
    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        services.lazy.forEach {
            _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions)
        }
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        
        window = UIWindow()
        let nav = BaseNavigationController()
        let keychainService = KeychainService()
        coordinator = AppCoordinator(navigationController: nav, keychainService: keychainService)
        coordinator?.start()
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
}
