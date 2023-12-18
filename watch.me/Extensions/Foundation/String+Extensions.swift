import Foundation

extension String {
    func maskEmail() -> String {
        let components = self.components(separatedBy: "@")
        
        guard components.count == 2 else {
            return self
        }
        
        let username = components[0]
        let domain = components[1]
        
        let maskedUsername = String(username.prefix(3)) + String(repeating: "*",
                                                                 count: max(username.count - 3, 0))
        
        return maskedUsername + "@" + domain
    }
}
