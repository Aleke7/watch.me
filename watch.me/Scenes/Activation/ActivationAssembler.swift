import Foundation

final class ActivationAssembler {
    static func assemble() -> ActivationViewController {
        let viewController = ActivationViewController()
        let interactor = ActivationInteractor()
        let presenter = ActivationPresenter()
        let router = ActivationRouter()

        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
