import Foundation

final class ActivationAssembler {
    static func assemble(maskedEmail: String) -> ActivationViewController {
        let viewController = ActivationViewController(maskedEmail: maskedEmail)
        let interactor = ActivationInteractor()
        let presenter = ActivationPresenter()
        let router = ActivationRouter()

        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
