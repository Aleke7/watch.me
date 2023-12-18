import UIKit

protocol AppImageProtocol {
    var rawValue: String { get }
}

extension AppImageProtocol {
    
    var uiImage: UIImage? {
        guard let image = UIImage(named: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
    
    var systemImage: UIImage? {
        guard let image = UIImage(systemName: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
}

enum AppImage: String, AppImageProtocol {
    
    // MARK: - Common
    
    case appLogo = "app_logo"
    case appIcon = "AppIcon"
    
    // MARK: - Sign
    
    case eyeClosed = "eye_closed"
    case eyeOpened = "eye_opened"
    case checkNotPressed = "check1"
    case checkPressed = "check2"
    case headphones
    
    // MARK: - Profile
    
    case profileIcon = "profile_icon"
    case themeIcon = "theme_icon"
    case starIcon = "star_icon"
    case arrowRightIcon = "arrow_right_icon"
    
}
