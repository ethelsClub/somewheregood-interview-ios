//
//  LoginViewControllerTests.swift
//  SomewhereGoodInterviewTests
//
//  Created by Vanessa Flores on 1/7/21.
//

import XCTest
@testable import SomewhereGoodInterview

class LoginViewControllerTests: XCTestCase {

    var sut: LoginViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = LoginViewController()
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_emailInput_isValid() {
        sut.emailTextField.text = "car"
        
        XCTAssertTrue(sut.isValidEmail())
    }
    
    func test_passwordInput_isValid() {
        sut.passwordTextField.text = "password1"
        
        XCTAssertTrue(sut.isValidPassword())
    }
    
    func test_init_loginErrorLabelIsHidden() {
        sut.emailTextField.text = ""
        sut.passwordTextField.text = ""
        
        XCTAssertTrue(sut.loginErrorLabel.isHidden)
    }
    
    func test_loginErrorLabel_whenInvalidLogin_isNotHidden() {
        sut.emailTextField.text = ""
        sut.passwordTextField.text = ""

        sut.loginButtonPressed(sut.loginButton)

        XCTAssertFalse(sut.loginErrorLabel.isHidden)
    }
    
    func test_loginErrorLabel_whenValidLogin_isHidden() {
        sut.emailTextField.text = "car"
        sut.passwordTextField.text = "password1"

        sut.loginButtonPressed(sut.loginButton)

        XCTAssertTrue(sut.loginErrorLabel.isHidden)
    }

}
