import Foundation

struct Weather: Decodable {
    
    let description: [WeatherDescription]
    let temperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let name: String
    let date: TimeInterval
    
    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case name
        case date = "dt"
    }
    
    enum MainKeys: String, CodingKey {
        case temperature = "temp"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
    }
    
    init(from decoder: Decoder) throws {
        let weatherData = try decoder.container(keyedBy: CodingKeys.self)
        let main = try weatherData.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        
        self.description = try weatherData.decode([WeatherDescription].self, forKey: .weather)
        self.temperature = try main.decode(Double.self, forKey: .temperature)
        self.minTemperature = try main.decode(Double.self, forKey: .minTemperature)
        self.maxTemperature = try main.decode(Double.self, forKey: .maxTemperature)
        self.name = try weatherData.decode(String.self, forKey: .name)
        self.date = try weatherData.decode(TimeInterval.self, forKey: .date)
    }
}
