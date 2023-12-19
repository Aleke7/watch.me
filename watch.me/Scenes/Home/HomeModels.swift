import UIKit

enum HomeModels {

    // MARK: - Use Cases
    
    struct Request {
        let page: Int
        let pageSize: Int
    }
    
    struct Response {
        let watchModel: WatchModel?
    }
    
    struct ViewModel {
        let watches: [Watch]
    }

}
