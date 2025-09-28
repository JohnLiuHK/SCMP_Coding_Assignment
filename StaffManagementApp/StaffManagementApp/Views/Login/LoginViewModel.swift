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
    private let authService: AuthService
    let session: SessionManager

    init(authService: AuthService = AuthService(client: APIClient()),
         session: SessionManager) {
        self.authService = authService
        self.session = session
    }

    func validateEmail() -> Bool {
        guard email.contains("@") else {
            errorMessage = "Invalid email"
            return false
        }
        return true
    }
    
    func validatePassword() -> Bool {
        guard password.range(of: "^[A-Za-z0-9]{6,10}$", options: .regularExpression) != nil else {
            errorMessage = "Invalid password"
            return false
        }
        return true
    }

    func login() {
        guard validateEmail(), validatePassword() else { return }
        isLoading = true
        
        authService.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let loginResponse):
                    self?.session.login(with: loginResponse.token)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
