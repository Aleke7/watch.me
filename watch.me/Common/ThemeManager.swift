import UIKit

final class ThemeManager {
    static let shared = ThemeManager()

    private init() {}

    enum Theme: String {
        case light
        case dark
    }

    var currentTheme: Theme {
        if let storedTheme = UserDefaults.standard.string(forKey: "appTheme"),
           let theme = Theme(rawValue: storedTheme) {
            return theme
        } else {
            return .light
        }
    }

    public func toggleTheme() {
        let newTheme: Theme = (currentTheme == .light) ? .dark : .light
        applyTheme(newTheme)
        UserDefaults.standard.set(newTheme.rawValue, forKey: "appTheme")
    }

    public func applyTheme(_ theme: Theme) {
        switch theme {
        case .light:
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        case .dark:
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        }
    }
}
