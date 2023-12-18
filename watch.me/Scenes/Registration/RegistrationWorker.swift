import UIKit
import Alamofire

protocol RegistrationProtocol {
    func requestUserCreation(registerUser: RegisterUser,
                             completion: @escaping (Result<UserModel, AFError>) -> Void)
}

final class RegistrationWorker: RegistrationProtocol {
    
    func requestUserCreation(registerUser: RegisterUser,
                             completion: @escaping (Result<UserModel, AFError>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "localhost"
        urlComponents.port = 4000
        urlComponents.path = "/v1/users"
        
        guard let url = urlComponents.url else {
            fatalError("Could not create url")
        }
        
        let jsonParameters: [String: Any] = [
            "name": registerUser.name,
            "email": registerUser.email,
            "password": registerUser.password
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: jsonParameters,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type": "application/json"])
            .validate()
            .responseDecodable(of: UserModel.self) { response in
                completion(response.result)
            }
    }
    
}
