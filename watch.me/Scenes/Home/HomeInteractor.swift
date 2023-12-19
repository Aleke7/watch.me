import UIKit

protocol HomeBusinessLogic {
    
}

protocol HomeDataStore {
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {

    // MARK: - Properties

    private lazy var worker = HomeWorker()
    var presenter: HomePresentationLogic?

}
