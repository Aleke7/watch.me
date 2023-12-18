import UIKit

protocol ActivationCommunicationDelegate {
    
}

protocol ActivationDisplayLogic: AnyObject {
    
}

final class ActivationViewController: ThemedViewController, ActivationDisplayLogic {

    // MARK: - Properties

    var router: (ActivationRoutingLogic & ActivationDataPassing)?
    var interactor: ActivationBusinessLogic?
    
    private var maskedEmail: String

    // MARK: - Object lifecycle

    init(maskedEmail: String) {
        self.maskedEmail = maskedEmail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        super.loadView()
        let activationView = ActivationView(maskedEmail: maskedEmail)
        view = activationView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
