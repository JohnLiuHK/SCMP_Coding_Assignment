//
//  SessionManager.swift
//  StaffManagementApp
//
//  Created by John Liu on 28/9/2025.
//
import Combine

class SessionManager: ObservableObject {
    @Published var isLoggedIn = false
    @Published var token: String?

    func login(with token: String) {
        self.token = token
        self.isLoggedIn = true
    }

    func logout() {
        self.token = nil
        self.isLoggedIn = false
    }
}
