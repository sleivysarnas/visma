import UIKit

protocol AirInteractorInput {
    func setup(_ air: Weather)
}

final class AirInteractor {
    
    var presenter: AirPresenterInput!
    private var state: Air.View.State?
    
    init() {
        self.state = nil
    }
}

extension AirInteractor: AirInteractorInput {
    
    func setup(_ air: Weather) {
        state = configureState(air)
        presenter.present(state!)
    }
    
    private func configureState(_ air: Weather) -> Air.View.State {
        return Air.View.State(
            description: description(air.description),
            temperature: temperature(air.temperature),
            minMaxTemperature: minMaxTemperature(air),
            name: name(air)
        )
    }
    
    private func description(_ descriptions: [WeatherDescription]) -> String {
        var description = String()
        for element in descriptions {
            description.append("\(element.description.capitalizingFirstLetter()) / ")
        }
        return String(description.dropLast(3))
    }
    
    private func temperature(_ temperature: Double) -> String {
        return temperature.toString()
    }
    
    private func minMaxTemperature(_ air: Weather) -> String {
        return String("\(air.minTemperature.toString())° / \(air.maxTemperature.toString())°")
    }
    
    private func name(_ air: Weather) -> String {
        return "\(air.name) / \(date(air.date))"
    }
    
    private func date(_ timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
}

