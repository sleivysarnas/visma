import UIKit

protocol AirRouterInput {
    func routeToHome()
}

final class AirRouter {
    weak var viewController: AirViewController!
}

extension AirRouter: AirRouterInput {
    
    @objc func routeToHome() {
        viewController.navigationController?.popViewController(animated: true)
        viewController.dismiss(animated: true, completion: nil)
    }
}


