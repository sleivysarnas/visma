import UIKit

protocol HomePresenterInput {
    func present(_ weather: Weather)
}

final class HomePresenter {
    weak var viewController: HomeViewControllerInput!
}

extension HomePresenter: HomePresenterInput {
    
    func present(_ weather: Weather) {
        viewController.display(weather)
    }
}
