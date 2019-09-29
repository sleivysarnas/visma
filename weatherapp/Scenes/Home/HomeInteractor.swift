import UIKit

protocol HomeInteractorInput {
    func submitCityInput(_ city: String?)
}

final class HomeInteractor {
    
    var presenter: HomePresenterInput!
}

extension HomeInteractor: HomeInteractorInput {
    
    func submitCityInput(_ city: String?) {
        guard let city = city else { return }
        
        let success: (Weather) -> () = { [weak self] weather in
            self?.presenter.present(weather)
        }
        
        let failure: (Error) -> () = { [weak self] error in
            let alert = UIAlertController(title: "Oops!", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            self?.presenter.present(alert)
        }
        
        APIRouter
            .Weather
            .get(city: city)
            .request()
            .response(success: success, failure: failure)
    }
}
