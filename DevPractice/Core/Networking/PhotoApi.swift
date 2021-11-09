//
//  PhotoApi.swift
//  DevPractice
//
//  Created by Tony Mu on 8/11/21.
//

import Foundation

enum PhotoApi {
    // subs
    case get
    case savePhoto
    
    private var urlString: String {
        let base = "https://picsum.photos/v2"
        switch self {
        case .get:
            return "\(base)/list"
        case .savePhoto:
            return "test-not-real"
        }
    }
    
    private var method: HttpMethod {
        switch self {
        case .get:
            return .get
        case .savePhoto:
            return .post
        }
    }

    func request(withBody body: Data? = nil) throws -> URLRequest {
        guard let url = URL(string: urlString) else {
            throw ApiError.urlError("invalid url: \(urlString)")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpBody = body
        return request
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

enum ApiError: Error {
    case urlError(String)
    case notFound
    case invalidedResponse
    case unknown(Error)
    case decodingError
}

extension URLRequest {
    
}

extension HTTPURLResponse {
    static let successResponseCodeRange = 200..<299
    
    var isValidResponse: Bool {
        return 200..<299 ~= statusCode
    }
}

extension URLRequest {
    func send<T: Decodable>(completion: @escaping (Result<T, ApiError>)-> Void) {
        
        URLSession.shared.dataTask(with: self) { (data, response, error) in
            if let error = error {
                completion(.failure(ApiError.unknown(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.isValidResponse, let data = data else {
                completion(.failure(ApiError.invalidedResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let values = try decoder.decode(T.self, from: data)
                completion(.success(values))
            } catch {
                completion(.failure(ApiError.decodingError))
            }
            
        }.resume()
    }
}


