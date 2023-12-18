import Foundation

final class ProfileAssembler {
    static func assemble(email: String) -> ProfileViewController {
        let viewController = ProfileViewController(email: email)
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()

        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
