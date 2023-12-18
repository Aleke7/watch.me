import UIKit

protocol LoginPresentationLogic {
    func presentToken(response: LoginModels.Response)
}

final class LoginPresenter: LoginPresentationLogic {

    // MARK: - Properties

    weak var viewController: LoginDisplayLogic?
    
    // MARK: - LoginPresentationLogic
    
    func presentToken(response: LoginModels.Response) {
        guard let tokenModel = response.tokenModel else {
            let viewModel = LoginModels.ViewModel(alertMessage: "Incorrect email or password")
            viewController?.showAlert(viewModel: viewModel)
            return
        }
        
        let keychainService = KeyChainService()
        keychainService.setAuthToken(token: tokenModel.authenticationToken.token,
                                     expiry: tokenModel.authenticationToken.expiry)
        
        let viewModel = LoginModels.ViewModel(alertMessage: nil)
        viewController?.showAlert(viewModel: viewModel)
    }

}
