//
//  StaffModel.swift
//  StaffManagementApp
//
//  Created by John Liu on 27/9/2025.
//

struct StaffModel: Codable, Identifiable, Equatable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let avatar: String
}
