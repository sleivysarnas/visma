import UIKit

protocol HomeRouterInput {
    func routeToWeather(with weather: Weather)
}

final class HomeRouter {
    weak var viewController: HomeViewController!
}

extension HomeRouter: HomeRouterInput {
    
    func routeToWeather(with weather: Weather) {
        let airViewController = AirViewController(with: weather)
        viewController.navigationController?.pushViewController(airViewController, animated: true)
    }
}

