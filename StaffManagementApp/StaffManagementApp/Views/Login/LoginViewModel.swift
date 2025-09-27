//
//  LoginViewModel.swift
//  StaffManagementApp
//
//  Created by John Liu on 27/9/2025.
//

import Foundation
import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isLoggedIn = false
    
    
}
