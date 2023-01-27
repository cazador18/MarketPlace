import Foundation
import UIKit

internal final class SwinjectServices: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        assemblyApplication()
        return true
    }
    
    private func assemblyApplication() {
        Swinjectable.assembler.apply(
            assemblies: [
                NetworkServicesAssembly(),
                ModulesAssembly(),
                CommonServicesAssembly()
            ]
        )
    }
}
