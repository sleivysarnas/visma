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
        
        let failure: (Error) -> () = { error in
            print(error)
        }
        
        APIRouter
            .Weather
            .get(city: city)
            .request()
            .response(success: success, failure: failure)
    }
}
