import Foundation

final class WatchesAssembler {
    static func assemble() -> WatchesViewController {
        let viewController = WatchesViewController()
        let interactor = WatchesInteractor()
        let presenter = WatchesPresenter()
        let router = WatchesRouter()

        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
