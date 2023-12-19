import UIKit

protocol HomeBusinessLogic {
    
}

final class HomeInteractor: HomeBusinessLogic {

    // MARK: - Properties

    private lazy var worker = HomeWorker()
    var presenter: HomePresentationLogic?

}
