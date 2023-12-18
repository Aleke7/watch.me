import UIKit

enum ActivationModels {

    // MARK: - Use Cases
    
    struct Request {
        let activationCode: String
    }
    
    struct Response {
        let userModel: UserModel?
    }
    
    struct ViewModel {
        let alertMessage: String
        let isActivated: Bool
    }
    
}
