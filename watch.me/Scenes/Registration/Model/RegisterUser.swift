import Foundation

struct RegisterUser: Encodable {
    let name: String
    let email: String
    let password: String
}
