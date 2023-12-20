import Foundation
import Alamofire

protocol WatchesProtocol {
    func requestMoreWatches(searchText: String,
                            page: Int,
                            pageSize: Int,
                            completion: @escaping (Result<WatchModel, AFError>) -> Void)
    
}

final class WatchesWorker: WatchesProtocol {
    
    private let keychainService = KeyChainService()
    
    func requestMoreWatches(searchText: String,
                            page: Int,
                            pageSize: Int,
                            completion: @escaping (Result<WatchModel, AFError>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "localhost"
        urlComponents.port = 4000
        urlComponents.path = "/v1/watches"
        urlComponents.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "page_size", value: "\(pageSize)"),
            URLQueryItem(name: "brand", value: "\(searchText)")
        ]
        
        
        guard let url = urlComponents.url else {
            fatalError("Could not create url")
        }
        
        var headers: HTTPHeaders = ["Content-Type": "application/json"]
        if let authToken = keychainService.getAuthToken() {
            headers["Authorization"] = "Bearer \(authToken)"
        }
        
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers)
            .validate()
            .responseDecodable(of: WatchModel.self) { response in
                completion(response.result)
            }
        
    }
    
}
