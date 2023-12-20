import Foundation

struct SearchModel: Codable, Equatable {
    var id: UUID = UUID()
    let text: String
    
}

func ==(lhs: SearchModel, rhs: SearchModel) -> Bool {
    return lhs.id == rhs.id
}
