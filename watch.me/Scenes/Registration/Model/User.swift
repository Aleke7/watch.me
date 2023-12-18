import Foundation

// MARK: - UserModel

struct UserModel: Codable {
    let user: User
}

// MARK: - User

struct User: Codable {
    let id: Int
    let createdAt: Date
    let name, email: String
    let activated: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case name, email, activated
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        
        let dateString = try container.decode(String.self, forKey: .createdAt)
        if let date = ISO8601DateFormatter().date(from: dateString) {
            createdAt = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .createdAt,
                                                   in: container,
                                                   debugDescription: "Format does not match")
        }

        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        activated = try container.decode(Bool.self, forKey: .activated)
    }
}
