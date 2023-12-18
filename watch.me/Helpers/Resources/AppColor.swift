import UIKit

protocol AppColorProtocol {
    var rawValue: String { get }
}

extension AppColorProtocol {
    var uiColor: UIColor {
        guard let color = UIColor.init(named: rawValue) else {
            fatalError("Could not find color with name \(rawValue)")
        }
        return color
    }
    
    var cgColor: CGColor {
        return uiColor.cgColor
    }
}

enum AppColor: String, AppColorProtocol {
    
    // MARK: - Theme
    
    case themeMainBackgroundColor
    case themeSecondaryBackgroundColor
    case themeShadowColor
    case themeBorderColor
    case themeButtonColor
    case themeTabBarColor
    
    // MARK: - Common
    
    case grey0
    case grey40
    case grey60
    case grey70
    case grey80
    case grey100
    
}
