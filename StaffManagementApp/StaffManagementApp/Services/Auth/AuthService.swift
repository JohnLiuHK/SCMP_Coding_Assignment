//
//  AuthService.swift
//  StaffManagementApp
//
//  Created by John Liu on 27/9/2025.
//

struct AuthService {
    let client: APIClient

    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        client.request(
            endpoint: APIConstants.loginEndpoint,
            method: "POST",
            body: ["email": email, "password": password],
            completion: completion
        )
    }
}
