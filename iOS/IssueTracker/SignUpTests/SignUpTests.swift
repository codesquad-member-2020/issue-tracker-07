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
    
    func generateString(length: ClosedRange<Int>) -> String {
        return (0..<Int.random(in: length)).map({ _ in "a" }).joined()
    }
    
    override func setUp() {
        super.setUp()
        viewModel = SignUpViewModel()
    }
    
    func testUserNameValid() {
        viewModel.signUpInfo.ID = generateString(length: 6...12)
        do {
            let userName = try XCTUnwrap(viewModel.isIDValid.value)
            XCTAssertTrue(userName)
        } catch {
            XCTFail()
        }
    }
    
    func testUserNameLengthUnder() {
        viewModel.signUpInfo.ID = generateString(length: 0...5)
        do {
            let userName = try XCTUnwrap(viewModel.isIDValid.value)
            XCTAssertFalse(userName)
        } catch {
            XCTFail()
        }
    }
    
    func testUserNameLengthOver() {
        viewModel.signUpInfo.ID = generateString(length: 13...100)
        do {
            let userName = try XCTUnwrap(viewModel.isIDValid.value)
            XCTAssertFalse(userName)
        } catch {
            XCTFail()
        }
    }
    
    func testPasswordValid() {
        viewModel.signUpInfo.password = generateString(length: 6...12)
        do {
            let password = try XCTUnwrap(viewModel.isPasswordValid.value)
            XCTAssertTrue(password)
        } catch {
            XCTFail()
        }
    }
    
    func testPasswordLengthUnder() {
        viewModel.signUpInfo.password = generateString(length: 0...5)
        do {
            let password = try XCTUnwrap(viewModel.isPasswordValid.value)
            XCTAssertFalse(password)
        } catch {
            XCTFail()
        }
    }
    
    func testPasswordLengthOver() {
        viewModel.signUpInfo.password = generateString(length: 13...100)
        do {
            let password = try XCTUnwrap(viewModel.isPasswordValid.value)
            XCTAssertFalse(password)
        } catch {
            XCTFail()
        }
    }
    
    func testConfirmPasswordValid() {
        viewModel.signUpInfo.password = "password"
        viewModel.signUpInfo.confirmPassword = "password"
        do {
            let isValid = try XCTUnwrap(viewModel.isConfirmPasswordValid.value)
            XCTAssertTrue(isValid)
        } catch {
            XCTFail()
        }
    }

    func testConfirmPasswordInvalid() {
        viewModel.signUpInfo.password = "password1"
        viewModel.signUpInfo.confirmPassword = "password2"
        do {
            let isValid = try XCTUnwrap(viewModel.isConfirmPasswordValid.value)
            XCTAssertFalse(isValid)
        } catch {
            XCTFail()
        }
    }

    func testSignUpEnabled() {
        testUserNameValid()
        testPasswordValid()
        testConfirmPasswordValid()
        XCTAssertTrue(viewModel.isEnabled.value)
    }

    func testSignUpForbid() {
        testUserNameLengthOver()
        testUserNameLengthUnder()
        testPasswordLengthOver()
        testPasswordLengthUnder()
        testConfirmPasswordInvalid()
        XCTAssertFalse(viewModel.isEnabled.value)
    }
}
