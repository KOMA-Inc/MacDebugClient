import Foundation

extension MacDebug {

    struct SetStringUserPropertyInput: Encodable {

        let name: String
        let value: String
        let date = Date()

        enum CodingKeys: String, CodingKey {
            case name = "event_name"
            case value
            case date
        }
    }
}
