import Foundation

// MARK: - TokenModel

struct TokenModel: Decodable {
    let authenticationToken: AuthenticationToken

    enum CodingKeys: String, CodingKey {
        case authenticationToken = "authentication_token"
    }
}

// MARK: - AuthenticationToken

struct AuthenticationToken: Decodable {
    let token: String
    let expiry: Date

    enum CodingKeys: String, CodingKey {
        case token
        case expiry
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        token = try container.decode(String.self, forKey: .token)

        let dateString = try container.decode(String.self, forKey: .expiry)

        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        if let date = formatter.date(from: dateString) {
            expiry = date
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: .expiry,
                in: container,
                debugDescription: "Date string does not match expected format"
            )
        }
    }

}
