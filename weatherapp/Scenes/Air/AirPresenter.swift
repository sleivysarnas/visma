import UIKit

protocol AirPresenterInput {
    func present(_ state: Air.View.State)
}

final class AirPresenter {
    weak var viewController: AirViewControllerInput!
}

extension AirPresenter: AirPresenterInput {
    
    func present(_ state: Air.View.State) {
        viewController.display(state)
    }
}

