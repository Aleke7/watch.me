import UIKit
import SnapKit

final class SplashViewController: ThemedViewController {
    
    // MARK: - UI
    
    private lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = AppImage.appLogo.uiImage
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView.layer.masksToBounds = false
        return imageView
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showMainInterface(rootViewController: self.getRootViewController())
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        appIconImageView.layer.shadowRadius = 10
        appIconImageView.layer.shadowColor = AppColor.themeShadowColor.cgColor
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = AppColor.themeMainBackgroundColor.uiColor
        view.addSubview(appIconImageView)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        appIconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Main Interface
    
    private func showMainInterface(rootViewController: UIViewController) {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            if let sceneDelegate =
                UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = rootViewController
            }
        }, completion: nil)
    }
    
    // MARK: - RootViewController
    
    private func getRootViewController() -> UIViewController {
        let keychainService = KeyChainService()
        
        let homeTabBarController = HomeTabBarController()
        let loginViewController = UINavigationController(rootViewController: LoginAssembler.assemble())
        
        let rootViewController = ((keychainService.getAuthToken() != nil) && keychainService.isTokenValid())
                                    ? homeTabBarController
                                    : loginViewController
        
        return rootViewController
    }

}
