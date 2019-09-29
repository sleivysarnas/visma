import Alamofire

public typealias APIRequest = DataRequest

public protocol APIRoutable: URLRequestConvertible {
    
    // MARK: - Optional values
    
    var httpMethod: HTTPMethod { get }
    var httpHeaders: [String: String]? { get }
    var httpBody: Any? { get }
    var urlBase: String { get }
    var parameters: [String: Any]? { get }
    
    // MARK: - Required values
    
    var endpoint: String { get }
}

public extension APIRoutable {
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var httpHeaders: [String: String]? {
        return nil
    }
    
    var httpBody: Any? {
        return nil
    }
    
    var urlBase: String {
        return "https://api.openweathermap.org/data/2.5/"
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try urlBase.asURL()
        
        var urlRequest = URLRequest(url: try URL.endpoint(endpoint, relativeTo: url))
        urlRequest.httpMethod = httpMethod.rawValue
        
        switch httpMethod {
        case .get:
            if let parameters = parameters {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            }
        default:
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if let httpBody = httpBody {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: httpBody)
            } else if let parameters = parameters {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            }
        }
        
        if let httpHeaders = httpHeaders {
            for (headerKey, headerValue) in httpHeaders {
                urlRequest.addValue(headerValue, forHTTPHeaderField: headerKey)
            }
        }
        
        return urlRequest
    }
    
    func request() -> APIRequest {
        return Alamofire.request(self)
    }
}

