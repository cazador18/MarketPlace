import Foundation
import Swinject
import SwinjectAutoregistration

public enum Swinjectable {
    public static var container: Container = .init()
    public static var assembler: Assembler = .init(container: container)
}

extension Container {
    public static var container: Container {
        return Swinjectable.container
    }
    
    public func assemble(assembly: Assembly) {
        assembly.assemble(container: self)
    }
}
