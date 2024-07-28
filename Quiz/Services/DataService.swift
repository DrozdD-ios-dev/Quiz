import Foundation

final class DataService {
    
    static func decodeJsonData() throws -> Questions {
        guard let url = Bundle.main.url(forResource: "Questions", withExtension: "json") else {
            throw NSError(domain: "URLNotFound", code: 1, userInfo: nil)
        }
        let result = try Data(contentsOf: url)
        let resultData = try JSONDecoder().decode(Questions.self, from: result)
        return resultData
    }
}
