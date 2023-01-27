// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let closeButton = ImageAsset(name: "Close button")
  internal static let blueTextColor = ColorAsset(name: "blueTextColor")
  internal static let errorTextColor = ColorAsset(name: "errorTextColor")
  internal static let normalTextColor = ColorAsset(name: "normalTextColor")
  internal static let primaryTextColor = ColorAsset(name: "primaryTextColor")
  internal static let secondaryTextColor = ColorAsset(name: "secondaryTextColor")
  internal static let telNumberTextColor = ColorAsset(name: "telNumberTextColor")
  internal static let termsTextColor = ColorAsset(name: "termsTextColor")
  internal static let tittleTextColor = ColorAsset(name: "tittleTextColor")
  internal static let primaryButtonColor = ColorAsset(name: "PrimaryButtonColor")
  internal static let primaryButtonDisabledColor = ColorAsset(name: "PrimaryButtonDisabledColor")
  internal static let primaryButtonTappedColor = ColorAsset(name: "PrimaryButtonTappedColor")
  internal static let secondaryButtonColor = ColorAsset(name: "SecondaryButtonColor")
  internal static let backgroundColor = ColorAsset(name: "backgroundColor")
  internal static let borderColor = ColorAsset(name: "borderColor")
  internal static let redButtonColor = ColorAsset(name: "redButtonColor")
  internal static let categoryBackgroundColor = ColorAsset(name: "categoryBackgroundColor")
  internal static let sellFasterButtonColor = ColorAsset(name: "sellFasterButtonColor")
  internal static let checkBoxGreen = ImageAsset(name: "checkBoxGreen")
  internal static let checkBoxMagentaDisable = ImageAsset(name: "checkBoxMagentaDisable")
  internal static let checkBoxSquare = ImageAsset(name: "checkBoxSquare")
  internal static let checkBoxSquareDisable = ImageAsset(name: "checkBoxSquareDisable")
  internal static let checkboxMagenta = ImageAsset(name: "checkboxMagenta")
  internal static let deleteButton = ImageAsset(name: "deleteButton")
  internal static let radioButton = ImageAsset(name: "radioButton")
  internal static let radioButtonDisable = ImageAsset(name: "radioButtonDisable")
  internal static let startPageIcon = ImageAsset(name: "StartPageIcon")
  internal static let errorPageIcon = ImageAsset(name: "errorPageIcon")
  internal static let error500 = ImageAsset(name: "error500")
  internal static let faqButton = ImageAsset(name: "FAQButton")
  internal static let addIcon = ImageAsset(name: "AddIcon")
  internal static let allCategory = ImageAsset(name: "AllCategory")
  internal static let autoCategory = ImageAsset(name: "AutoCategory")
  internal static let avatarIcon = ImageAsset(name: "AvatarIcon")
  internal static let childrenCategory = ImageAsset(name: "ChildrenCategory")
  internal static let gardenCategory = ImageAsset(name: "GardenCategory")
  internal static let homeCategory = ImageAsset(name: "HomeCategory")
  internal static let jobCategory = ImageAsset(name: "JobCategory")
  internal static let servicesCategory = ImageAsset(name: "ServicesCategory")
  internal static let technicsCategory = ImageAsset(name: "TechnicsCategory")
  internal static let activePageItem = ImageAsset(name: "activePageItem")
  internal static let findCategory = ImageAsset(name: "findCategory")
  internal static let innactivePageItem = ImageAsset(name: "innactivePageItem")
  internal static let medicalCategory = ImageAsset(name: "medicalCategory")
  internal static let petsCategory = ImageAsset(name: "petsCategory")
  internal static let restCategory = ImageAsset(name: "restCategory")
  internal static let sportHobbyCategory = ImageAsset(name: "sport&HobbyCategory")
  internal static let mask = ImageAsset(name: "Mask")
  internal static let union = ImageAsset(name: "union")
  internal static let emptyAvatar = ImageAsset(name: "EmptyAvatar")
  internal static let blackBackButton = ImageAsset(name: "blackBackButton")
  internal static let emptyImg = ImageAsset(name: "emptyImg")
  internal static let magentaBackButton = ImageAsset(name: "magentaBackButton")
  internal static let oMarketLogo = ImageAsset(name: "OMarketLogo")
  internal static let oMarketWhiteLogo = ImageAsset(name: "oMarketWhiteLogo")
  internal static let unMask = ImageAsset(name: "UnMask")
  internal static let addImageBlock = ImageAsset(name: "AddImageBlock")
  internal static let mapIcon = ImageAsset(name: "MapIcon")
  internal static let oDengi = ImageAsset(name: "ODengi")
  internal static let profileCheck = ImageAsset(name: "ProfileCheck")
  internal static let vipProfile = ImageAsset(name: "VIPProfile")
  internal static let deleteIcon = ImageAsset(name: "deleteIcon")
  internal static let verifiedNumber = ImageAsset(name: "verifiedNumber")
  internal static let ellipse = ImageAsset(name: "ellipse")
  internal static let ggwp = ImageAsset(name: "ggwp")
  internal static let secondTextColor = ColorAsset(name: "secondTextColor")
  internal static let temperColorSet = ColorAsset(name: "temperColorSet")
  internal static let filterSearchBackButton = ImageAsset(name: "filterSearchBackButton")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
