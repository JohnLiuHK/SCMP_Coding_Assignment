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
    private var staffService: StaffService

    init(staffService: StaffService = StaffService(client: APIClient())) {
        self.staffService = staffService
    }

    func fetchStaffList(page: Int = 1) {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        
        staffService.fetchStaffList(page: page) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let response):
                    if page == 1 {
                        self.staffList = response.data
                    } else {
                        self.staffList.append(contentsOf: response.data)
                    }
                    self.currentPage = response.page
                    self.totalPages = response.total_pages
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // For pagination
    func fetchNextPageIfNeeded(currentItem: StaffModel) {
        guard let lastItem = staffList.last else { return }
        
        if currentItem.id == lastItem.id && currentPage < totalPages {
            fetchStaffList(page: currentPage + 1)
        }
    }

}
