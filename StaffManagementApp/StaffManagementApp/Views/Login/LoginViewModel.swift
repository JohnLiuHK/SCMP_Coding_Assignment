//
//  LoginViewModel.swift
//  StaffManagementApp
//
//  Created by John Liu on 27/9/2025.
//

import Combine
import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isLoggedIn = false
    @Published var token: String?
    private let authService: AuthService

    init(authService: AuthService = AuthService(client: APIClient())) {
        self.authService = authService
    }

    func validateInputs() -> Bool {
        guard email.contains("@"),
            password.range(of: "^[A-Za-z0-9]{6,10}$", options: .regularExpression) != nil
        else {
            errorMessage = "Invalid email or password"
            return false
        }
        return true
    }

    func login() {
        guard validateInputs() else { return }

        isLoading = true
        authService.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let loginResponse):
                    self?.token = loginResponse.token
                    self?.isLoggedIn = true
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
