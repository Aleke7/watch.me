//
//  SearchModels.swift
//  watch.me
//
//  Created by Almat Begaidarov on 20.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum SearchModels {

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
