import UIKit

protocol ProfileBusinessLogic {
    
}

protocol ProfileDataStore {
}

final class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {

    // MARK: - Properties

    private lazy var worker = ProfileWorker()
    var presenter: ProfilePresentationLogic?

    
}
