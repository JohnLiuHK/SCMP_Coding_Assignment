//
//  StaffResponseModel.swift
//  StaffManagementApp
//
//  Created by John Liu on 28/9/2025.
//

import Foundation

struct StaffListResponseModel: Codable {
    let page: Int
    let per_page: Int
    let total: Int
    let total_pages: Int
    let data: [StaffModel]
}
