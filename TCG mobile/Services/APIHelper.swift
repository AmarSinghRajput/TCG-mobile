//
//  APIHelper.swift
//  TCG mobile
//
//  Created by Amar Kumar Singh on 25/04/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum APIError: Error {
    case invalidURL
    case noData
    case httpError(statusCode: Int)
    case requestFailed(Error)
    case invalidResponse
    case encodingFailed(Error)
    case decodingFailed(Error)
    case networkError(Error)
    case unknownError
}


class APIHelper {
    
    // MARK: - Properties
    
    static let shared = APIHelper()
    private init() {}
    
    // MARK: - POST Method with JSON request body
    
    func post<T: Decodable, E: Encodable>(endpoint: APIEndPoints, body: E, completion: @escaping (Result<T, APIError>) -> Void) {
        // Create the URL for the request
        guard let url = URL(string: "\(endpoint)") else {
            completion(.failure(.invalidURL))
            return
        }

        // Create the URLRequest object with the POST method and the JSON content type
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Encode the request body as JSON data
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(body)
            request.httpBody = jsonData
        } catch {
            completion(.failure(.encodingFailed(error)))
            return
        }

        // Create a URLSessionDataTask to make the request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Handle any errors
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }

            // Ensure that we have valid response data
            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            // Attempt to decode the response data
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(T.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        // Start the data task
        task.resume()
    }
    
    // MARK: - POST Method with plain/text request body
    
    func post<T: Codable>(endpoint: APIEndPoints, data: String, completion: @escaping (Result<T, APIError>) -> Void) {
        // Create the URL for the request
        guard let url = URL(string: "\(endpoint.endpoint)") else {
            completion(.failure(.invalidURL))
            return
        }

        // Create the URLRequest object with the POST method and plain text content type
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("text/plain", forHTTPHeaderField: "Content-Type")

        // Encode the data as plain text and set it as the request body
        request.httpBody = data.data(using: .utf8)

        // Create a URLSessionDataTask to make the request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Handle any errors
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }

            // Ensure that we have a valid HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            // Ensure that we have valid response data
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            // Check the status code of the HTTP response
            switch httpResponse.statusCode {
            case 200..<300:
                // The request was successful, pass the response data to the completion handler
                let decoder = JSONDecoder()
                do {
                    let responseObject = try decoder.decode(T.self, from: data)
                    completion(.success(responseObject))
                } catch {
                    completion(.failure(.decodingFailed(error)))
                }
            default:
                // There was an error with the request, return the error
                completion(.failure(.httpError(statusCode: httpResponse.statusCode)))
            }
        }

        // Start the data task
        task.resume()
    }

    // MARK: - GET Method
    
    func get<T: Decodable>(endpoint: APIEndPoints, completion: @escaping (Result<T, APIError>) -> Void) {
        // Create the URL for the request
        guard let url = URL(string: "\(endpoint)") else {
            completion(.failure(.invalidURL))
            return
        }

        // Create the URLRequest object with the GET method
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // Create a URLSessionDataTask to make the request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Handle any errors
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }

            // Ensure that we have valid response data
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            // Attempt to decode the response data
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(T.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        // Start the data task
        task.resume()
    }

}








