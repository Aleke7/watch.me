import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let keychainService = KeyChainService()
        
        let homeTabBarController = HomeTabBarController()
        let loginViewController = LoginAssembler.assemble()
        
        let mainViewController = ((keychainService.getAuthToken() != nil) && keychainService.isTokenValid())
                                    ? homeTabBarController
                                    : loginViewController
        
        window?.rootViewController = SplashViewController(rootViewController: mainViewController)
        window?.makeKeyAndVisible()
    }
    
}

