import UIKit

protocol RegistrationBusinessLogic {
    func createUser(request: RegistrationModels.Request)
}

protocol RegistrationDataStore {
    
}

final class RegistrationInteractor: RegistrationBusinessLogic, RegistrationDataStore {

    // MARK: - Properties

    private lazy var worker = RegistrationWorker()
    var presenter: RegistrationPresentationLogic?
    
    func createUser(request: RegistrationModels.Request) {
        
        let registerUser = RegisterUser(name: request.email,
                                        email: request.email,
                                        password: request.password)
        
        worker.requestUserCreation(registerUser: registerUser) { [weak self] result in
            switch result {
                
            case .success(let userModel):
                let response = RegistrationModels.Response(userModel: userModel)
                self?.presenter?.presentUserModel(response: response)
            case .failure(let error):
                print(error.localizedDescription)
                let response = RegistrationModels.Response(userModel: nil)
                self?.presenter?.presentUserModel(response: response)
            }
        }
        
    }

}
