import Foundation
import AVFoundation

public class AudioController: ObservableObject {
    private let brownNoiseFileName = "brown_noise.mp3"
    
    public init() {}
    
    public func isBrownNoiseFileAvailable() -> Bool {
        guard let path = Bundle.main.path(forResource: "brown_noise", ofType: "mp3") else {
            return false
        }
        return FileManager.default.fileExists(atPath: path)
    }
} 