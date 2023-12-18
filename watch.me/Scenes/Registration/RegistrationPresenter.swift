import UIKit

protocol RegistrationPresentationLogic {
    func presentUserModel(response: RegistrationModels.Response)
}

final class RegistrationPresenter: RegistrationPresentationLogic {

    // MARK: - Properties

    weak var viewController: RegistrationDisplayLogic?
    
    // MARK: - RegistrationPresentationLogic
    
    func presentUserModel(response: RegistrationModels.Response) {
        guard let userModel = response.userModel else {
            let viewModel = RegistrationModels.ViewModel(alertMessage: "Something went wrong")
            viewController?.showAlert(viewModel: viewModel)
            return
        }
        
        let email = userModel.user.email
        UserDefaults.standard.setValue(email, forKey: "email")
        
        let viewModel = RegistrationModels.ViewModel(alertMessage: nil)
        viewController?.showAlert(viewModel: viewModel)
    }

}
