import UIKit

protocol HomePresentationLogic {
    func presentWatches(response: HomeModels.Response)
}

final class HomePresenter: HomePresentationLogic {

    // MARK: - Properties

    weak var viewController: HomeDisplayLogic?
    
    // MARK: - HomePresentationLogic
    
    func presentWatches(response: HomeModels.Response) {
        guard let watches = response.watchModel?.watches else {
            let viewModel = HomeModels.ViewModel(watches: [])
            viewController?.displayWatches(viewModel: viewModel)
            return
        }
        
        let viewModel = HomeModels.ViewModel(watches: watches)
        viewController?.displayWatches(viewModel: viewModel)
    }
    
}
