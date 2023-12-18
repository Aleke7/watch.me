import UIKit

enum LoginModels {

    // MARK: - Use Cases
    
    struct Request {
        let email: String
        let password: String
    }
    
    struct Response {
        let tokenModel: TokenModel?
    }
    
    struct ViewModel {
        let alertMessage: String?
    }

}
