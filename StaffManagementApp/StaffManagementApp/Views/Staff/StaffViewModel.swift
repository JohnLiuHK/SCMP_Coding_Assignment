//
//  StaffViewModel.swift
//  StaffManagementApp
//
//  Created by John Liu on 27/9/2025.
//

import Foundation
import Combine

class StaffViewModel: ObservableObject {
    @Published var staffList: [StaffModel] = []
    @Published var currentPage = 1
    @Published var totalPages = 1
    @Published var isLoading = false
    @Published var errorMessage: String?
}
