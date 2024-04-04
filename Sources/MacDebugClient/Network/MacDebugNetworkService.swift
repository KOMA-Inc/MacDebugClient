import CombinePlus
import Foundation
import Networking

class MacDebugNetworkService: Networking.NetworkService<MacDebugEndpoint> {

    override func headers(for endpoint: Endpoint) -> [String: String]? {
        [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }

    private let jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        return encoder
    }()

    func logAnalyticsEvent(
        host: String,
        name: String,
        properties: [String: String]?
    ) -> AnyPublisher<String, APIError> {
        request(MacDebugEndpoint(
            host: host,
            endpoint: .logAnalyticsEvent(name: name, properties: properties)
        ))
    }

    func logIncrementUserProperty(
        host: String,
        name: String,
        value: Int
    ) -> AnyPublisher<String, APIError> {
        request(MacDebugEndpoint(
            host: host,
            endpoint: .logIncrementUserProperty(name: name, value: value)
        ))
    }

    func logSetIntUserProperty(
        host: String,
        name: String,
        value: Int
    ) -> AnyPublisher<String, APIError> {
        request(MacDebugEndpoint(
            host: host,
            endpoint: .logSetIntUserProperty(name: name, value: value)
        ))
    }

    func logSetStringUserProperty(
        host: String,
        name: String,
        value: String
    ) -> AnyPublisher<String, APIError> {
        request(MacDebugEndpoint(
            host: host,
            endpoint: .logSetStringUserProperty(name: name, value: value)
        ))
    }

    func logRequest(
        host: String,
        id: String,
        endpoint: String,
        method: String,
        headers: [String: String]?,
        body: Data?
    ) -> AnyPublisher<String, APIError> {
        request(MacDebugEndpoint(
            host: host,
            endpoint: .logRequest(input: MacDebug.LogRequestInput(
                id: id,
                endpoint: endpoint,
                method: method,
                headers: headers,
                body: body
            ))
        ))
    }

    func logResponse(
        host: String,
        id: String,
        statusCode: Int?,
        endpoint: String,
        method: String,
        headers: [String: String]?,
        body: Data?,
        error: String?
    ) -> AnyPublisher<String, APIError> {
        request(MacDebugEndpoint(
            host: host,
            endpoint: .logResponse(input: MacDebug.LogResponseInput(
                id: id,
                statusCode: statusCode,
                endpoint: endpoint,
                method: method,
                headers: headers,
                body: body,
                error: error
            ))
        ))
    }

    override func encoder(for endpoint: MacDebugEndpoint) -> JSONEncoder {
        jsonEncoder
    }
}
