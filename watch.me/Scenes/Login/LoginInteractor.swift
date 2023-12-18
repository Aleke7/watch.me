import UIKit

protocol LoginBusinessLogic {
    func authenticateUser(request: LoginModels.Request)
}

final class LoginInteractor: LoginBusinessLogic {

    // MARK: - Properties

    private lazy var worker = LoginWorker()
    var presenter: LoginPresentationLogic?

    // MARK: - LoginBusinessLogic
    
    func authenticateUser(request: LoginModels.Request) {
        
        let loginUser = LoginUser(email: request.email,
                                  password: request.password)
        
        UserDefaults.standard.setValue(loginUser.email, forKey: "email")

        worker.requestUserAuthentication(loginUser: loginUser) { [weak self] result in
            switch result {
            case .success(let tokenModel):
                let response = LoginModels.Response(tokenModel: tokenModel)
                self?.presenter?.presentToken(response: response)
            case .failure(_):
                let response = LoginModels.Response(tokenModel: nil)
                self?.presenter?.presentToken(response: response)
            }
        }
    }
}
