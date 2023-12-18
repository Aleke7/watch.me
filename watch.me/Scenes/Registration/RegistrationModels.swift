import UIKit

enum RegistrationModels {

    // MARK: - Use Cases
    
    struct Request {
        let email: String
        let password: String
    }
    
    struct Response {
        let userModel: UserModel?
    }
    
    struct ViewModel {
        let alertMessage: String?
        let maskedEmail: String?
    }
    
}
