import UIKit

protocol ActivationBusinessLogic {

}

protocol ActivationDataStore {
}

final class ActivationInteractor: ActivationBusinessLogic, ActivationDataStore {

    // MARK: - Properties

    lazy var worker = ActivationWorker()
    var presenter: ActivationPresentationLogic?

    
}
