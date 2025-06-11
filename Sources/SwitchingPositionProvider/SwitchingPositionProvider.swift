import CoreLocation
import MapsIndoors

@objc(SwitchingPositionProvider)
public final class SwitchingPositionProvider: NSObject, MPPositionProvider {

    public weak var delegate: (any MapsIndoors.MPPositionProviderDelegate)?

    public var latestPosition: MapsIndoors.MPPositionResult? {
        get {
            providers.reduce(nil) { bestPosition, provider in
                guard let providerPosition = provider.latestPosition else { return bestPosition }

                return if providerPosition.accuracy > 0, providerPosition.accuracy < bestPosition?.accuracy ?? Double.infinity {
                    providerPosition
                } else {
                    bestPosition
                }
            }
        }
        set { /* Should not be set by others */ }
    }

    public var providers = [MPPositionProvider]()

    public override init() {
        super.init()
    }

    @objc public func addPositionProvider(_ provider: MPPositionProvider) {
        provider.delegate = self
        providers.append(provider)
    }

    @objc public func removePositionProvider(_ provider: MPPositionProvider) {
        provider.delegate = nil
        providers.removeAll { $0 === provider }
    }

    override public var debugDescription: String {
        let debugInfos = providers.sorted { $0.latestPosition?.accuracy ?? Double.infinity < $1.latestPosition?.accuracy ?? Double.infinity }
            .compactMap { ($0 as? CustomDebugStringConvertible)?.debugDescription }
        return debugInfos.joined(separator: "\n\n")
    }

    // MARK: Properties from AppPositionProvider protocol
    @objc public var enableDebugInfo = false

}

extension SwitchingPositionProvider: MPPositionProviderDelegate {
    
    public func onPositionUpdate(position: MapsIndoors.MPPositionResult) {
        guard let latestPosition else { return }
        delegate?.onPositionUpdate(position: latestPosition)
    }
    
}
