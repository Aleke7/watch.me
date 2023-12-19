import Foundation

// MARK: - WatchModel
struct WatchModel: Codable {
    let metadata: Metadata
    let watches: [Watch]
}

// MARK: - Metadata
struct Metadata: Codable {
    let currentPage, pageSize, firstPage, lastPage: Int
    let totalRecords: Int

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case pageSize = "page_size"
        case firstPage = "first_page"
        case lastPage = "last_page"
        case totalRecords = "total_records"
    }
}

// MARK: - Watch
struct Watch: Codable {
    let id: Int
    let brand, model, dialColor, strapType: String
    let diameter: Int
    let energy: String
    let gender: Gender
    let price: Int
    let imageURL: String
    let version: Int

    enum CodingKeys: String, CodingKey {
        case id, brand, model
        case dialColor = "dial_color"
        case strapType = "strap_type"
        case diameter, energy, gender, price
        case imageURL = "image_url"
        case version
    }
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
}
