import UIKit

protocol ProfileBusinessLogic {
    
}

final class ProfileInteractor: ProfileBusinessLogic {

    // MARK: - Properties

    private lazy var worker = ProfileWorker()
    var presenter: ProfilePresentationLogic?

    
}
