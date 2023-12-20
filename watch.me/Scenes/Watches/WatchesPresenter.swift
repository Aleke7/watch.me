import UIKit

protocol WatchesPresentationLogic {
    func presentWatches(response: WatchesModels.Response)
}

final class WatchesPresenter: WatchesPresentationLogic {

    // MARK: - Properties

    weak var viewController: WatchesDisplayLogic?

    // MARK: - WatchesPresentationLogic
    
    func presentWatches(response: WatchesModels.Response) {
        guard let watches = response.watchModel?.watches else {
            let viewModel = WatchesModels.ViewModel(watches: [])
            viewController?.displayWatches(viewModel: viewModel)
            return
        }
        
        let viewModel = WatchesModels.ViewModel(watches: watches)
        viewController?.displayWatches(viewModel: viewModel)
    }
    
}
