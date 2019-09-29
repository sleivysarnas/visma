public enum APIError: Error {
    case responseIsInvalid
    case serializationError(underlyingError: Error)
    case networkingError(underlyingError: Error)
    
    public var title: String {
        switch self {
        case .responseIsInvalid:
            return "Response is invalid."
        case .serializationError:
            return "Serialization failed."
        case .networkingError:
            return "Request failed."
        }
    }
}
