import UIKit

protocol WatchesBusinessLogic {
    func getWatches(request: WatchesModels.Request)
}

final class WatchesInteractor: WatchesBusinessLogic {

    // MARK: - Properties
    
    private lazy var worker = WatchesWorker()
    var presenter: WatchesPresentationLogic?
    
    // MARK: - WatchesBusinessLogic
    
    func getWatches(request: WatchesModels.Request) {
        worker.requestMoreWatches(searchText: request.searchText,
                                  page: request.page,
                                  pageSize: request.pageSize) { [weak self] result in
            switch result {
            case .success(let watchModel):
                let response = WatchesModels.Response(watchModel: watchModel)
                self?.presenter?.presentWatches(response: response)
            case .failure(_):
                let response = WatchesModels.Response(watchModel: nil)
                self?.presenter?.presentWatches(response: response)
            }
        }
    }

}
