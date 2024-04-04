import Foundation

extension MacDebug {

    struct SetIntUserPropertyInput: Encodable {

        let name: String
        let value: Int
        let date = Date()

        enum CodingKeys: String, CodingKey {
            case name = "event_name"
            case value
            case date
        }
    }
}
