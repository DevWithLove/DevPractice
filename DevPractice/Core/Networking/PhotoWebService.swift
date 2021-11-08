//
//  PhotoWebService.swift
//  DevPractice
//
//  Created by Tony Mu on 8/11/21.
//

import Foundation

typealias PhotoWebServiceResult = (Result<[PhotoDto], ApiError>) -> Void

protocol PhotoWebServiceProtocol {
    func get(completion: @escaping PhotoWebServiceResult )
}

class PhotoWebService: PhotoWebServiceProtocol {
    func get(completion: @escaping PhotoWebServiceResult) {
        do {
            let request = try PhotoApi.get.request()
            request.send(completion: completion)
        } catch {
            completion(.failure(.unknown(error)))
        }
    }
    
    func save() {
        // encode object
        let encoder = JSONEncoder()
        let requestDto = SavePhotoRequest(id: "tests")
        let body = try! encoder.encode(requestDto)
        let request = try! PhotoApi.savePhoto.request(withBody: body)
       // request.send(completion: <#T##(Result<Decodable, ApiError>) -> Void#>)
    }
    
    
}

struct SavePhotoRequest: Encodable {
    let id: String?
}
