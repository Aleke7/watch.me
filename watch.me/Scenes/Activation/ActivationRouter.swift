import UIKit

protocol ActivationRoutingLogic {
}

protocol ActivationDataPassing {
    var dataStore: ActivationDataStore? { get }
}

final class ActivationRouter: ActivationRoutingLogic, ActivationDataPassing {

    // MARK: - Properties

    weak var viewController: ActivationViewController?
    var dataStore: ActivationDataStore?

    
}
