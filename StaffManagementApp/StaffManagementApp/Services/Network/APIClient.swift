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

    func request<T: Decodable>(
        endpoint: String,
        method: String = "GET",
        params: [String: Any]? = nil,
        headers: [String: String]? = nil,
        body: [String: Any]? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var urlComponents = URLComponents(string: baseURL + endpoint)
        if let params = params {
            urlComponents?.queryItems = params.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
        }

        guard let url = urlComponents?.url else {
            completion(
                .failure(
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

        
        request.setValue(APIConstants.jsonHeader, forHTTPHeaderField: "Content-Type")

        // Headers handling
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        // Body handling
        if let body = body, method != "GET" {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }

        // Request
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            // Handle HTTP status errors
            if let httpResponse = response as? HTTPURLResponse,
                !(200...299).contains(httpResponse.statusCode) {
                let err = NSError(
                    domain: "",
                    code: httpResponse.statusCode,
                    userInfo: [
                        NSLocalizedDescriptionKey:
                            "Server error (\(httpResponse.statusCode))"
                    ]
                )
                completion(.failure(err))
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
