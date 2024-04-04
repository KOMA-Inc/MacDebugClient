import Networking

struct MacDebugEndpoint: Endpoint {

    let host: String
    let endpoint: Endpoint

    var path: String {
        endpoint.path
    }

    var method: Networking.HTTPMethod {
        endpoint.method
    }

    var body: Encodable? {
        endpoint.body
    }
}

extension MacDebugEndpoint {

    enum Endpoint {

        case logAnalyticsEvent(name: String, properties: [String: String]?)
        case logIncrementUserProperty(name: String, value: Int)
        case logSetIntUserProperty(name: String, value: Int)
        case logSetStringUserProperty(name: String, value: String)

        case logRequest(input: MacDebug.LogRequestInput)
        case logResponse(input: MacDebug.LogResponseInput)

        var path: String {
            switch self {
            case .logAnalyticsEvent:
                "/log/analytics/send-event"
            case .logIncrementUserProperty:
                "/log/analytics/increment-property"
            case .logSetIntUserProperty:
                "/log/analytics/set-int-property"
            case .logSetStringUserProperty:
                "/log/analytics/set-string-property"
            case .logRequest:
                "/log/server/request"
            case .logResponse:
                "/log/server/response"
            }
        }

        var method: Networking.HTTPMethod {
            .post
        }

        var body: Encodable? {
            switch self {
            case let .logAnalyticsEvent(name, properties):
                MacDebug.LogEventInputModel(name: name, properties: properties)
            case let .logIncrementUserProperty(name, value):
                MacDebug.IncrementUserPropertyInput(name: name, value: value)
            case let .logSetIntUserProperty(name, value):
                MacDebug.SetIntUserPropertyInput(name: name, value: value)
            case let .logSetStringUserProperty(name, value):
                MacDebug.SetStringUserPropertyInput(name: name, value: value)
            case let .logRequest(input):
                input
            case let .logResponse(input):
                input
            }
        }
    }
}
