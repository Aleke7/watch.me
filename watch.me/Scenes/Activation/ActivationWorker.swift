import UIKit
import Alamofire

protocol ActivationProtocol {
    func requestUserActivation(activationCode: String,
                               completion: @escaping (Result<UserModel, AFError>) -> Void)
}

final class ActivationWorker: ActivationProtocol {
    
    func requestUserActivation(activationCode: String,
                               completion: @escaping (Result<UserModel, Alamofire.AFError>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "localhost"
        urlComponents.port = 4000
        urlComponents.path = "/v1/users/activated"
        
        guard let url = urlComponents.url else {
            fatalError("Could not create url")
        }
        
        let jsonParameters: [String: Any] = [
            "token": activationCode
        ]
        
        AF.request(url,
                   method: .put,
                   parameters: jsonParameters,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type": "application/json"])
            .validate()
            .responseDecodable(of: UserModel.self) { response in
                completion(response.result)
            }
    }
    
}
