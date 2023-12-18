import UIKit

protocol ActivationBusinessLogic {
    func activateUser(request: ActivationModels.Request)
}

final class ActivationInteractor: ActivationBusinessLogic {

    // MARK: - Properties

    private lazy var worker = ActivationWorker()
    var presenter: ActivationPresentationLogic?
    
    // MARK: - ActivationBusinessLogic
    
    func activateUser(request: ActivationModels.Request) {
        
        worker.requestUserActivation(activationCode: request.activationCode) { [weak self] result in
            switch result {
            case .success(let userModel):
                let response = ActivationModels.Response(userModel: userModel)
                self?.presenter?.presentUserModel(response: response)
            case .failure(_):
                let response = ActivationModels.Response(userModel: nil)
                self?.presenter?.presentUserModel(response: response)
            }
        }
    
    }
    
}
