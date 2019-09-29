import Alamofire

extension APIRouter {
    
    enum Weather {
        case get(city: String)
    }
}

extension APIRouter.Weather: APIRoutable {
    
    var httpMethod: HTTPMethod {
        switch self {
        case .get:
            return .get
        }
    }
    
    var endpoint: String {
        switch self {
        case .get(let city):
            return "weather?q=\(city),LTU&appid=7587eaff3affbf8e56a81da4d6c51d06&units=metric"
        }
    }
}
