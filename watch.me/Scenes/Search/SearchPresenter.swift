import UIKit

protocol SearchPresentationLogic {
    func presentWatches(response: SearchModels.Response)
}

final class SearchPresenter: SearchPresentationLogic {

    // MARK: - Properties

    weak var viewController: SearchDisplayLogic?
    
    // MARK: - SearchPresentationLogic
    
    func presentWatches(response: SearchModels.Response) {
        guard let watches = response.watchModel?.watches else {
            let viewModel = WatchesModels.ViewModel(watches: [])
            viewController?.displayWatches(viewModel: viewModel)
            return
        }
        
        let viewModel = WatchesModels.ViewModel(watches: watches)
        viewController?.displayWatches(viewModel: viewModel)
    }
    
}
