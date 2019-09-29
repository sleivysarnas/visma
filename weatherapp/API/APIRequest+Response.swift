import Alamofire

extension APIRequest {
    
    @discardableResult
    public func response<T: Decodable>(success: ((T) -> Void)? = nil, failure: ((APIError) -> Void)? = nil) -> Self {
        return validate().responseJSON(
            completionHandler: { response in
                switch response.result {
                case .success:
                    do {
                        if let jsonData = response.data {
                            let object = try JSONDecoder().decode(T.self, from: jsonData)
                            success?(object)
                        } else {
                            failure?(APIError.responseIsInvalid)
                        }
                    } catch let error {
                        failure?(APIError.serializationError(underlyingError: error))
                    }
                case .failure(let error):
                    failure?(.networkingError(underlyingError: error))
                }
        })
    }
}

