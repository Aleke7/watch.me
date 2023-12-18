import UIKit
import ProgressHUD

protocol RegistrationDisplayLogic: AnyObject {
    func showAlert(viewModel: RegistrationModels.ViewModel)
}

final class RegistrationViewController: ThemedViewController {

    // MARK: - Properties

    var router: (RegistrationRoutingLogic & RegistrationDataPassing)?
    var interactor: RegistrationBusinessLogic?

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
        let registrationView = RegistrationView()
        view = registrationView
        registrationView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

}

extension RegistrationViewController: RegistrationDisplayLogic {
    func showAlert(viewModel: RegistrationModels.ViewModel) {
        guard let alertMessage = viewModel.alertMessage else {
            router?.routeToActivation(navigationController: navigationController,
                                      maskedEmail: viewModel.maskedEmail ?? "")
            return
        }
        
        ProgressHUD.showBanner("Error!", alertMessage)
    }
    
}

extension RegistrationViewController: RegistrationDelegate {
    
    func readInputFields(email: String?, password: String?) {
        guard let email = email, !email.isEmpty else {
            ProgressHUD.showBanner("Oops", "Please enter email")
            return
        }
        
        guard let password = password, !password.isEmpty else {
            ProgressHUD.showBanner("Oops", "Please enter password")
            return
        }
        
        if password.count < 8 {
            ProgressHUD.showBanner("Oops", "Password must be at least 8 bytes long")
            return
        }
        
        let request = RegistrationModels.Request(email: email, password: password)
        interactor?.createUser(request: request)
    }

    func showLoginPage() {
        router?.routeToLogin(navigationController: navigationController)
    }
    
}

