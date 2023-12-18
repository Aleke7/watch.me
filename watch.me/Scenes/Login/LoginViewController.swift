import UIKit

protocol LoginCommunicationDelegate: AnyObject {
    func showRegistrationPage()
    func showHomePage(email: String)
}

protocol LoginDisplayLogic: AnyObject {
    
}

final class LoginViewController: ThemedViewController {

    // MARK: - Properties

    var router: (LoginRoutingLogic & LoginDataPassing)?
    var interactor: LoginBusinessLogic?

    // MARK: - Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        let loginView = LoginView()
        view = loginView
        loginView.communicationDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

}

extension LoginViewController: LoginDisplayLogic {
    
}

extension LoginViewController: LoginCommunicationDelegate {
    func showRegistrationPage() {
        router?.routeToRegistration(navigationController: navigationController)
    }
    
    func showHomePage(email: String) {
        router?.routeToHome(navigationController: navigationController, email: email)
    }
}
