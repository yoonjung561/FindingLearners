//
//  APIClient.swift
//  FindingLearners
//
//  Created by YoonJung Kwak on 4/21/26.
//

import Foundation

/// ```
/// {
///     "name: "Jaesung"
/// }
/// ```

class APIClient {
    func request<T: Decodable>(urlString: String, type: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else { throw NSError(domain: "", code: 000) }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        if let httpResponse = response as? HTTPURLResponse {
            print(httpResponse.statusCode)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let decodedData = try decoder.decode(T.self, from: data)
        return decodedData
    }
}
