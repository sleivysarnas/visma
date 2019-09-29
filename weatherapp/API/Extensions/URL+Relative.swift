import Foundation

enum URLConstructionError: Error {
    case urlIsInvalid
}

extension URL {
    
    static func endpoint(_ string: String, relativeTo baseURL: URL) throws -> URL {
        assert(baseURL.absoluteString.last == "/", "Base URL must end with /")
        assert(string.first != "/", "Endpoint must not start with /")
        
        guard let formattedString = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw URLConstructionError.urlIsInvalid
        }
        guard let url = URL(string: formattedString, relativeTo: baseURL) else {
            throw URLConstructionError.urlIsInvalid
        }
        return url
    }
}
