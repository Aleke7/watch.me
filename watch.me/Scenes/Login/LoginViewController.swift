import UIKit
import ProgressHUD

protocol LoginDisplayLogic: AnyObject {
    func showAlert(viewModel: LoginModels.ViewModel)
}

final class LoginViewController: ThemedViewController {

    // MARK: - Properties

    var router: LoginRoutingLogic?
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
        loginView.delegate = self
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

// MARK: - LoginDisplayLogic

extension LoginViewController: LoginDisplayLogic {
    
    func showAlert(viewModel: LoginModels.ViewModel) {
        guard let alertMessage = viewModel.alertMessage else {
            router?.routeToHome(navigationController: navigationController)
            return
        }
        
        ProgressHUD.showBanner("Alert", alertMessage)
    }
    
}

// MARK: - LoginDelegate

extension LoginViewController: LoginDelegate {
    func showRegistrationPage() {
        router?.routeToRegistration(navigationController: navigationController)
    }
    
    func readInputFields(email: String?, password: String?) {
        guard let email = email, !email.isEmpty else {
            ProgressHUD.showBanner("Oops", "Please enter email")
            return
        }
        
        guard let password = password, !password.isEmpty else {
            ProgressHUD.showBanner("Oops", "Please enter password")
            return
        }
        
        let request = LoginModels.Request(email: email, password: password)
        interactor?.authenticateUser(request: request)
    }
}
