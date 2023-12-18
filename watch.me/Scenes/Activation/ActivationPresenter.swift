import UIKit

protocol ActivationPresentationLogic {
    func presentUserModel(response: ActivationModels.Response)
}

final class ActivationPresenter: ActivationPresentationLogic {

    // MARK: - Properties

    weak var viewController: ActivationDisplayLogic?
    
    // MARK: - ActivationPresentationLogic
    
    func presentUserModel(response: ActivationModels.Response) {
        guard response.userModel != nil else {
            let viewModel = ActivationModels.ViewModel(alertMessage: "Activation code is invalid",
                                                       isActivated: false)
            viewController?.showAlert(viewModel: viewModel)
            return
        }
        
        let viewModel = ActivationModels.ViewModel(alertMessage: "Your account is activated",
                                                   isActivated: true)
        viewController?.showAlert(viewModel: viewModel)
    }
    
}
