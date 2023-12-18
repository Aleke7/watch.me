import UIKit
import ProgressHUD

protocol ProfileDisplayLogic: AnyObject {
    
}

final class ProfileViewController: ThemedViewController, ProfileDisplayLogic {
    
    // MARK: - Properties
    
    var router: ProfileRoutingLogic?
    var interactor: ProfileBusinessLogic?
    
    // MARK: - Object Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        let profileView = ProfileView()
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    // MARK: - Setup Navigation
    
    private func setupNavigation() {
        navigationItem.title = "Profile"
        let logoutButtonImage = UIImage(systemName: "person.crop.circle.badge.xmark")?.withTintColor(
            AppColor.themeButtonColor.uiColor,
            renderingMode: .alwaysOriginal)
        let logoutButton = UIBarButtonItem(image: logoutButtonImage,
                                           style: .plain,
                                           target: self,
                                           action: #selector(logoutButtonPressed))
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    // MARK: - Actions
    
    @objc
    private func logoutButtonPressed() {
        let alertController = UIAlertController(title: "Logout",
                                                message: "Are you sure you want to log out?",
                                                preferredStyle: .alert)
        
        let logoutAction = UIAlertAction(title: "Log Out", style: .destructive) { _ in
            let keychainService = KeyChainService()
            let isTokenRemoved = keychainService.removeToken()
            
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
                return
            }
            
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                if let sceneDelegate =
                    UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
                   isTokenRemoved {
                    let loginViewController =
                    UINavigationController(rootViewController: LoginAssembler.assemble())
                    sceneDelegate.window?.rootViewController = loginViewController
                }
            }, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
