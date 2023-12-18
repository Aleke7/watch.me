import Foundation
import KeychainSwift

private enum KeyChainEnums: String {
    case token = "authenticationToken"
    case expiry = "authenticationTokenExpiry"
}

protocol KeyChainServiceProtocol {
    func setAuthToken(token: String, expiry: Date)
    func getAuthToken() -> String?
    func isTokenValid() -> Bool
    func removeToken() -> Bool
}

struct KeyChainService: KeyChainServiceProtocol {
    
    // MARK: - Properties
    
    private let keychain = KeychainSwift()

    // MARK: - KeyChainServiceProtocol
    
    func setAuthToken(token: String, expiry: Date) {
        keychain.set(token, forKey: KeyChainEnums.token.rawValue)
        keychain.set("\(expiry.timeIntervalSince1970)", forKey: KeyChainEnums.expiry.rawValue)
    }
    
    func getAuthToken() -> String? {
        return keychain.get(KeyChainEnums.token.rawValue)
    }
    
    func isTokenValid() -> Bool {
        guard let expiryString = keychain.get(KeyChainEnums.expiry.rawValue),
                let expiryTimestamp = Double(expiryString) else {
            return false
        }
        
        let expiryDate = Date(timeIntervalSince1970: expiryTimestamp)
        return expiryDate > Date()
    }
    
    func removeToken() -> Bool {
        let tokenRemoved = keychain.delete(KeyChainEnums.token.rawValue)
        let expiryRemoved = keychain.delete(KeyChainEnums.expiry.rawValue)
        
        return tokenRemoved && expiryRemoved
    }
    
    
}
