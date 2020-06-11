//
//  SignUpTests.swift
//  SignUpTests
//
//  Created by 신한섭 on 2020/06/11.
//  Copyright © 2020 신한섭. All rights reserved.
//

import XCTest
@testable import IssueTracker

final class SignUpTests: XCTestCase {
    
    private var viewModel: SignUpViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = SignUpViewModel()
    }
    
    func testUserNameValid() {
        viewModel.userName.value = "aaaaaaaa"
        XCTAssertTrue(viewModel.isUserNameValid.value)
    }
    
    func testUserNameInvalid() {
        viewModel.userName.value = "aaa"
        XCTAssertFalse(viewModel.isUserNameValid.value)
        viewModel.userName.value = "aaaaaaaaaaaaaaa"
        XCTAssertFalse(viewModel.isUserNameValid.value)
    }
    
    func testPasswordValid() {
        viewModel.password.value = "aaaaaaaa"
        XCTAssertTrue(viewModel.isPasswordValid.value)
    }
    
    func testPasswordInvalid() {
        viewModel.password.value = "aaa"
        XCTAssertFalse(viewModel.isPasswordValid.value)
        viewModel.password.value = "aaaaaaaaaaaaaaa"
        XCTAssertFalse(viewModel.isPasswordValid.value)
    }
    
    func testConfirmPasswordValid() {
        viewModel.password.value = "aaaaaaaa"
        viewModel.confirmPassword.value = "aaaaaaaa"
        XCTAssertTrue(viewModel.isConfirmPasswordValid.value)
    }
    
    func testConfirmPasswordInvalid() {
        viewModel.password.value = "aaaaaaaa"
        viewModel.confirmPassword.value = "aaa"
        XCTAssertFalse(viewModel.isConfirmPasswordValid.value)
    }
    
    func testSignUpEnabled() {
        testUserNameValid()
        testPasswordValid()
        testConfirmPasswordValid()
        XCTAssertTrue(viewModel.isEnabled.value)
    }
    
    func testSignUpForbid() {
        testUserNameInvalid()
        testPasswordValid()
        testConfirmPasswordValid()
        XCTAssertFalse(viewModel.isEnabled.value)
    }
}
