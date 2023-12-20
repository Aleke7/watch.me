import Foundation

struct HistoryService {
    
    static let shared = HistoryService()
    
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    private let searchModelsKey = "searchModels"
    
    func saveSearchModels(_ searchModels: [SearchModel]) {
        do {
            let encodedData = try JSONEncoder().encode(searchModels)
            userDefaults.set(encodedData, forKey: searchModelsKey)
        } catch {
            print("Error encoding search models: \(error.localizedDescription)")
        }
    }
    
    func retrieveSearchModels() -> [SearchModel] {
        guard let savedData = userDefaults.data(forKey: searchModelsKey) else {
            return []
        }
        
        do {
            let decodedModels = try JSONDecoder().decode([SearchModel].self, from: savedData)
            return decodedModels
        } catch {
            print("Error decoding search models: \(error.localizedDescription)")
            return []
        }
    }
    
}
