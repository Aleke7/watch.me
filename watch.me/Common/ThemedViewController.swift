import UIKit

class ThemedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyCurrentTheme()
    }
    
    private func applyCurrentTheme() {
        let currentTheme = ThemeManager.shared.currentTheme
        ThemeManager.shared.applyTheme(currentTheme)
    }

}
