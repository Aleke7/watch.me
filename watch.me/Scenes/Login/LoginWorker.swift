import Foundation
import Alamofire

protocol LoginProtocol {
    func requestUserAuthentication(loginUser: LoginUser,
                                   completion: @escaping (Result<TokenModel, AFError>) -> Void)
}

final class LoginWorker: LoginProtocol {
    
    func requestUserAuthentication(loginUser: LoginUser,
                                   completion: @escaping (Result<TokenModel, AFError>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "localhost"
        urlComponents.port = 4000
        urlComponents.path = "/v1/tokens/authentication"
        
        guard let url = urlComponents.url else {
            fatalError("Could not create url")
        }
        
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        let jsonParameters: [String: Any] = [
            "email": loginUser.email,
            "password": loginUser.password
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: jsonParameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
            .validate()
            .responseDecodable(of: TokenModel.self) { response in
                completion(response.result)
            }
    }
    
}
