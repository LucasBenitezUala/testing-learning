//
//  LoginRouterTest.swift
//  SOLIDTests
//
//  Created by Lucas Benitez on 27/02/2023.
//

import XCTest
@testable import SOLID
@testable import UalaAuth
final class LoginRouterTest: XCTestCase {

    @MainActor
    func makeSut() -> LoginRouter {
        let mockLoginDemoViewType = UIViewController()
        var sut = LoginRouter()
        return sut
    }
    @MainActor
    func test(){
        let sut = makeSut()
        
    }

}
class MockLoginDemoViewType: UIViewController, LoginDemoViewType {
    var presenter: UalaAuth.LoginDemoPresenterType?
    
    func show(message: String) {
        
    }
    
    func loading(_ value: Bool) {
        
    }
    
    func show(alert: UIAlertController) {
        
    }
    
    
}
