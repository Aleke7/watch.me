import UIKit

protocol LoginBusinessLogic {
    
}

protocol LoginDataStore {
}

final class LoginInteractor: LoginBusinessLogic, LoginDataStore {

    // MARK: - Properties

    private lazy var worker = LoginWorker()
    var presenter: LoginPresentationLogic?

    
}
