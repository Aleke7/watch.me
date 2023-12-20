import UIKit

enum WatchesModels {

    // MARK: - Use Cases
    
    struct Request {
        let searchText: String
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
