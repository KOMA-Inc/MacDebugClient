import Foundation

extension MacDebug {

    struct LogRequestInput: Encodable {

        let id: String
        let endpoint: String
        let method: String
        let headers: [String: String]?
        let body: Data?
        let date = Date()

        enum CodingKeys: String, CodingKey {
            case id
            case endpoint
            case method = "http_method"
            case headers = "http_headers"
            case body
            case date
        }
    }
}
