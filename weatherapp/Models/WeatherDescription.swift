import Foundation

struct WeatherDescription: Codable {
    
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.description = try container.decode(String.self, forKey: .description)
    }
}
