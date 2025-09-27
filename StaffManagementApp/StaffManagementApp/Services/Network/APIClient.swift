//
//  APIClient.swift
//  StaffManagementApp
//
//  Created by John Liu on 27/9/2025.
//

import Foundation

class APIClient: NetworkService {
    private let baseURL: String

    init(baseURL: String = APIConstants.baseURL) {
        self.baseURL = baseURL
    }

    func request<T: Decodable>(endpoint: String, method: String = "GET", body: [String: Any]? = nil,
                               completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(
                    NSError(
                        domain: "",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]
                    )
                )
            )
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue(
            APIConstants.jsonHeader,
            forHTTPHeaderField: "Content-Type"
        )
        request.setValue(APIConstants.apiKey, forHTTPHeaderField: "x-api-key")

        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(
                    .failure(
                        NSError(
                            domain: "",
                            code: -1,
                            userInfo: [
                                NSLocalizedDescriptionKey: "No data returned"
                            ]
                        )
                    )
                )
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
