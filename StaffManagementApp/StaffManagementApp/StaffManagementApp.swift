//
//  StaffManagementApp.swift
//  StaffManagementApp
//
//  Created by John Liu on 27/9/2025.
//

import SwiftUI

@main
struct StaffManagementApp: App {
    @StateObject var navigationService = NavigationService()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(navigationService)
        }
    }
}
