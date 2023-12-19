import UIKit
import SnapKit

final class SplashViewController: ThemedViewController {
    
    // MARK: - Properties
    
    private var rootViewController: UIViewController
    
    // MARK: - UI
    
    private lazy var appIconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = AppImage.appLogo.uiImage
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        imageView.layer.masksToBounds = false
        return imageView
    }()
    
    // MARK: - Object Lifecycle
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showMainInterface(viewController: self.rootViewController)
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
    
    private func showMainInterface(viewController: UIViewController) {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            if let sceneDelegate =
                UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                
                guard viewController.tabBarController != nil else {
                    sceneDelegate.window?.rootViewController = viewController
                    return
                }
                
                let rootViewController =
                            UINavigationController(rootViewController: viewController)
                sceneDelegate.window?.rootViewController = rootViewController
                
            }
        }, completion: nil)
    }

}
