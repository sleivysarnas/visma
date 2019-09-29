import UIKit

protocol HomePresenterInput {
    func present(_ weather: Weather)
    func present(_ error: UIAlertController)
}

final class HomePresenter {
    weak var viewController: HomeViewControllerInput!
}

extension HomePresenter: HomePresenterInput {
    
    func present(_ weather: Weather) {
        viewController.display(weather)
    }
    
    func present(_ error: UIAlertController) {
        viewController.display(error)
    }
}
