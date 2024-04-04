import Foundation

extension MacDebug {

    struct LogEventInputModel: Encodable {

        let name: String
        let properties: [String: String]?
        let date = Date()

        enum CodingKeys: String, CodingKey {
            case name = "event_name"
            case properties = "event_properties"
            case date
        }
    }
}
