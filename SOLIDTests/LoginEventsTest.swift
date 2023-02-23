//
//  LoginEventsTest.swift
//  SOLIDTests
//
//  Created by Facundo Barboza on 22/02/2023.
//

import XCTest
import UalaCore
@testable import UalaAuth
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
    
    func test_login_success() async {
        let spectedScheme: Scheme = .develop
        let spectedCountryEnvironment: CountryEnvironment = .Argentina
        let spectedLoginData: LoginData = .init(username: "", password: "")
        let spectedDebugInvokedCount: Int = 2
        let spectedDebugParamentersCount: Int = 2
        
        let (sut, spy) = await makeSut()
        
        await sut.loginSuccess(scheme: spectedScheme, country: spectedCountryEnvironment, loginData: spectedLoginData)
        
        XCTAssertEqual(spy.debugIsInvokedCount, spectedDebugInvokedCount)
        XCTAssertEqual(spy.debugParameterList.count, spectedDebugParamentersCount)
        XCTAssertEqual(spy.debugParameterList[0] as! String, "Sheme -> \(spectedScheme.rawValue)")
        XCTAssertEqual(spy.debugParameterList[1] as! String, "Country -> \(spectedCountryEnvironment.rawValue)")
    }
}

class MockLoginManager: LogManager {
    var debugErrorIsInvoked: Bool = false
    var debugErrorParameter: Error?
    
    override func debugError(error: Error?, type: Any, fileName: String = #file, lineNumber: Int = #line) {
        debugErrorIsInvoked = true
        debugErrorParameter = error
    }
    
    var debugIsInvokedCount: Int = 0
    var debugParameterList: [Any] = []
    
    override func debug(info: Any, detailed: Bool = true, fileName: String = #file, lineNumber: Int = #line) {
        debugIsInvokedCount += 1
        debugParameterList.append(info)
    }
}
