import UIKit

protocol RegistrationBusinessLogic {
    func createUser(request: RegistrationModels.Request)
}

final class RegistrationInteractor: RegistrationBusinessLogic {

    // MARK: - Properties

    private lazy var worker = RegistrationWorker()
    var presenter: RegistrationPresentationLogic?
    
    // MARK: - RegistrationBusinessLogic
    
    func createUser(request: RegistrationModels.Request) {
        
        let registerUser = RegisterUser(name: request.email,
                                        email: request.email,
                                        password: request.password)
        
        worker.requestUserCreation(registerUser: registerUser) { [weak self] result in
            switch result {
            case .success(let userModel):
                let response = RegistrationModels.Response(userModel: userModel)
                self?.presenter?.presentUserModel(response: response)
            case .failure(_):
                let response = RegistrationModels.Response(userModel: nil)
                self?.presenter?.presentUserModel(response: response)
            }
        }
        
    }

}
