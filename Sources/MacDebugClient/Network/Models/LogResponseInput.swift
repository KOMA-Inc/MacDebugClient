import Foundation

extension MacDebug {

    struct LogResponseInput: Encodable {

        let id: String
        let statusCode: Int?
        let endpoint: String
        let method: String
        let headers: [String: String]?
        let body: Data?
        let error: String?
        let date = Date()

        enum CodingKeys: String, CodingKey {
            case id
            case statusCode = "status_code"
            case endpoint
            case method = "http_method"
            case headers = "http_headers"
            case body
            case error
            case date
        }
    }
}
