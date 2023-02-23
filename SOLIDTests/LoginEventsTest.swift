//
//  LoginEventsTest.swift
//  SOLIDTests
//
//  Created by Facundo Barboza on 22/02/2023.
//

import XCTest
@testable import UalaUtils
@testable import SOLID

final class LoginEventsTest: XCTestCase {
    
    @MainActor
    func makeSut() -> (sut: LoginEvents, spy: MockLoginManager) {
        let mockLogManager = MockLoginManager()
        var sut = LoginEvents(logManager: mockLogManager)
        return (sut, mockLogManager)
    }

    func test_get() async {
        let (sut, spy) = await makeSut()
        
        await sut.get(error: "")
        
        XCTAssertNotNil(spy.debugErrorParameter)
        XCTAssertEqual(spy.debugErrorParameter?.localizedDescription, "")
    }
}

class MockLoginManager: LogManager {
    var debugErrorIsInvoked: Bool = false
    var debugErrorParameter: Error?
    
    override func debugError(error: Error?, type: Any, fileName: String = #file, lineNumber: Int = #line) {
        debugErrorIsInvoked = true
        debugErrorParameter = error
    }
    
    override func debug(info: Any, detailed: Bool = true, fileName: String = #file, lineNumber: Int = #line) {
        
    }
}
