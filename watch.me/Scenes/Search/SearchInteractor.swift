import UIKit

protocol SearchBusinessLogic {
    func searchWatches(request: SearchModels.Request)
}

final class SearchInteractor: SearchBusinessLogic {

    // MARK: - Properties

    private lazy var worker = SearchWorker()
    var presenter: SearchPresentationLogic?

    // MARK: - SearchBusinessLogic

    func searchWatches(request: SearchModels.Request) {
        worker.searchWatches(searchText: request.searchText,
                             page: request.page,
                             pageSize: request.pageSize) { [weak self] result in
            switch result {
            case .success(let watchModel):
                let response = SearchModels.Response(watchModel: watchModel)
                self?.presenter?.presentWatches(response: response)
            case .failure(_):
                let response = SearchModels.Response(watchModel: nil)
                self?.presenter?.presentWatches(response: response)
            }
        }
    }
    
}
