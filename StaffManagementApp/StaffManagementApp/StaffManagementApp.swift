//
//  StaffManagementApp.swift
//  StaffManagementApp
//
//  Created by John Liu on 27/9/2025.
//

import SwiftUI

@main
struct StaffManagementApp: App {
    @StateObject private var sessionManager = SessionManager()

    var body: some Scene {
        WindowGroup {
            LoginView(sessionManager: sessionManager)
                .environmentObject(sessionManager)
        }
    }
}
