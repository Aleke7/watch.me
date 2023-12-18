import UIKit
import ProgressHUD

protocol ActivationDisplayLogic: AnyObject {
    func showAlert(viewModel: ActivationModels.ViewModel)
}

final class ActivationViewController: ThemedViewController {

    // MARK: - Properties

    var router: ActivationRoutingLogic?
    var interactor: ActivationBusinessLogic?
    
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
        let activationView = ActivationView()
        activationView.delegate = self
        view = activationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ActivationViewController: ActivationDisplayLogic {
    
    func showAlert(viewModel: ActivationModels.ViewModel) {
        ProgressHUD.showBanner("Alert", viewModel.alertMessage)
        if viewModel.isActivated {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            router?.routeToLogin(navigationController: navigationController)
        }
    }
    
}

// MARK: - ActivationDelegate

extension ActivationViewController: ActivationDelegate {
    
    func readActivationCode(activationCode: String) {
        let request = ActivationModels.Request(activationCode: activationCode)
        interactor?.activateUser(request: request)
    }
    
}
