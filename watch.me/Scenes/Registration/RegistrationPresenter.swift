import UIKit

protocol RegistrationPresentationLogic {
    func presentUserModel(response: RegistrationModels.Response)
}

final class RegistrationPresenter: RegistrationPresentationLogic {

    // MARK: - Properties

    weak var viewController: RegistrationDisplayLogic?
    
    func presentUserModel(response: RegistrationModels.Response) {
        guard response.userModel != nil else {
            let maskedEmail = response.userModel?.user.email.maskEmail()
            let viewModel = RegistrationModels.ViewModel(alertMessage: "Something went wrong",
                                                         maskedEmail: maskedEmail)
            viewController?.showAlert(viewModel: viewModel)
            return
        }
        
        let maskedEmail = response.userModel?.user.email.maskEmail()
        let viewModel = RegistrationModels.ViewModel(alertMessage: nil, maskedEmail: maskedEmail)
        viewController?.showAlert(viewModel: viewModel)
    }

}
