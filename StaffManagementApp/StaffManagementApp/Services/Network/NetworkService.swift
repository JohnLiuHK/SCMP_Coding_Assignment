//
//  NetworkService.swift
//  StaffManagementApp
//
//  Created by John Liu on 27/9/2025.
//

import Foundation

protocol NetworkService {
    func request<T: Decodable>(endpoint: String, method: String, params: [String: Any]?, headers: [String: String]?, body: [String: Any]?, completion: @escaping (Result<T, Error>) -> Void
    )
}
