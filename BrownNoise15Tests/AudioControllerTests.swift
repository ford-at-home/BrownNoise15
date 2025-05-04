import XCTest
@testable import BrownNoise15Core

final class AudioControllerTests: XCTestCase {
    var audioController: AudioController!
    let testBundle = Bundle(for: AudioControllerTests.self)
    
    override func setUp() {
        super.setUp()
        audioController = AudioController()
    }
    
    override func tearDown() {
        audioController = nil
        super.tearDown()
    }
    
    func testBrownNoiseFileExists() {
        // First test should fail since we haven't added the file yet
        XCTAssertFalse(audioController.isBrownNoiseFileAvailable(), "Brown noise file should not exist yet")
    }
} 