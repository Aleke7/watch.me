import UIKit

protocol HomeBusinessLogic {
    func getWatches(request: HomeModels.Request)
}

final class HomeInteractor: HomeBusinessLogic {

    // MARK: - Properties

    private lazy var worker = HomeWorker()
    var presenter: HomePresentationLogic?
    
    // MARK: - HomeBusinessLogic
    
    func getWatches(request: HomeModels.Request) {
        
        worker.requestMoreWatches(page: request.page,
                                  pageSize: request.pageSize) { [weak self] result in
            switch result {
            case .success(let watchModel):
                let response = HomeModels.Response(watchModel: watchModel)
                self?.presenter?.presentWatches(response: response)
            case .failure(_):
                let response = HomeModels.Response(watchModel: nil)
                self?.presenter?.presentWatches(response: response)
            }
        }
    }

}
