//
//  StaffService.swift
//  StaffManagementApp
//
//  Created by John Liu on 28/9/2025.
//
import SwiftUI

struct StaffService {
    let client: APIClient
    
    func fetchStaffList(
        page: Int,
        completion: @escaping (Result<StaffListResponseModel, Error>) -> Void
    ) {
        client.request(
            endpoint: "/users?page=\(page)",
            method: "GET",
//            headers: [
//                "Accept": "application/json",
//                "x-api-key": APIConstants.apiKey
//            ],
            completion: completion
        )
    }
}
