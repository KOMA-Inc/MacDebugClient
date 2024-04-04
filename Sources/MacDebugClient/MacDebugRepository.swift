import CombinePlus
import Foundation

public class MacDebugRepository {

    // MARK: - Private

    private let networkService = MacDebugNetworkService()
    private let infoProvider: MacDebugInfoProvider

    private var bag = CancelBag()
    private var shouldTrack: Bool {
        infoProvider.trackingEnabled
    }

    private lazy var host = "http://" + infoProvider.ipAddress
    private lazy var analyticsLoggingHost = host + ":5000"
    private lazy var httpLoggingHost = host + ":5001"

    // MARK: - Init

    public init(infoProvider: MacDebugInfoProvider) {
        self.infoProvider = infoProvider
    }
}

public extension MacDebugRepository {

    func logEvent(name: String, properties: [String: Any]?) {
        guard shouldTrack else { return }

        let properties: [String: String]? = properties.map { properties in
            Dictionary(
                uniqueKeysWithValues: properties.map { key, value in
                    (key, String(describing: value))
                }
            )
        }

        networkService.logAnalyticsEvent(
            host: analyticsLoggingHost,
            name: name,
            properties: properties
        )
        .sink()
        .store(in: &bag)
    }

    func logIncrementUserProperty(
        name: String,
        value: Int
    ) {
        guard shouldTrack else { return }

        networkService.logIncrementUserProperty(host: analyticsLoggingHost, name: name, value: value)
            .sink()
            .store(in: &bag)
    }

    func logSetUserProperty(
        name: String,
        value: Int
    ) {
        guard shouldTrack else { return }

        networkService.logSetIntUserProperty(host: analyticsLoggingHost, name: name, value: value)
            .sink()
            .store(in: &bag)
    }

    func logSetUserProperty(
        name: String,
        value: String
    ) {
        guard shouldTrack else { return }

        networkService.logSetStringUserProperty(host: analyticsLoggingHost, name: name, value: value)
            .sink()
            .store(in: &bag)
    }

    func logRequest(
        id: String,
        endpoint: String,
        method: String,
        headers: [String: String]?,
        body: Data?
    ) {
        guard shouldTrack else { return }

        networkService.logRequest(
            host: httpLoggingHost,
            id: id,
            endpoint: endpoint,
            method: method,
            headers: headers,
            body: body
        )
        .sink()
        .store(in: &bag)
    }

    func logResponse(
        id: String,
        statusCode: Int,
        endpoint: String,
        method: String,
        headers: [String: String]?,
        body: Data?,
        error: String?
    ) {
        guard shouldTrack else { return }

        networkService.logResponse(
            host: httpLoggingHost,
            id: id,
            statusCode: statusCode,
            endpoint: endpoint,
            method: method,
            headers: headers,
            body: body,
            error: error
        )
        .sink()
        .store(in: &bag)
    }
}
