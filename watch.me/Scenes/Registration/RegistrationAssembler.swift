import Foundation

final class RegistrationAssembler {
    static func assemble() -> RegistrationViewController {
        let viewController = RegistrationViewController()
        let interactor = RegistrationInteractor()
        let presenter = RegistrationPresenter()
        let router = RegistrationRouter()

        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
