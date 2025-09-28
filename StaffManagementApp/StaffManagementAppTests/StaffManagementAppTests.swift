//
//  StaffManagementAppTests.swift
//  StaffManagementAppTests
//
//  Created by John Liu on 28/9/2025.
//

import Testing

@testable import StaffManagementApp

@MainActor
struct StaffManagementAppTests {

    @Test func testValidateEmail_withValidEmail() async throws {
        let session = SessionManager()
        let vm = LoginViewModel(session: session)

        vm.email = "test@example.com"

        let result = vm.validateEmail()

        #expect(result == true)
        #expect(vm.errorMessage == nil)
    }
    
    @Test func testValidatePassword_withEmptyEmail() async throws {
        let session = SessionManager()
        let vm = LoginViewModel(session: session)

        vm.email = ""

        let result = vm.validateEmail()

        #expect(result == false)
        #expect(vm.errorMessage == "Invalid email")
    }

    @Test func testValidateInputs_withInvalidEmail() async throws {
        let session = SessionManager()
        let vm = LoginViewModel(session: session)

        vm.email = "testexample"

        let result = vm.validateEmail()

        #expect(result == false)
        #expect(vm.errorMessage == "Invalid email")
    }
    
    @Test func testValidatePassword_withValidPassword() async throws {
        let session = SessionManager()
        let vm = LoginViewModel(session: session)

        vm.password = "cityslicka"

        let result = vm.validatePassword()

        #expect(result == true)
        #expect(vm.errorMessage == nil)
    }

    @Test func testValidatePassword_withInvalidCharactersPassword() async throws {
        let session = SessionManager()
        let vm = LoginViewModel(session: session)

        vm.password = "%%%%%%%%%%"

        let result = vm.validatePassword()

        #expect(result == false)
        #expect(vm.errorMessage == "Invalid password")
    }
    
    @Test func testValidatePassword_withInvalidShortPassword() async throws {
        let session = SessionManager()
        let vm = LoginViewModel(session: session)

        vm.password = "12"

        let result = vm.validatePassword()

        #expect(result == false)
        #expect(vm.errorMessage == "Invalid password")
    }
    
    @Test func testValidatePassword_withEmptyPassword() async throws {
        let session = SessionManager()
        let vm = LoginViewModel(session: session)

        vm.password = ""

        let result = vm.validatePassword()

        #expect(result == false)
        #expect(vm.errorMessage == "Invalid password")
    }
}
