//
//  Photo.swift
//  DevPractice
//
//  Created by Tony Mu on 8/11/21.
//

import Foundation

struct Photo: Identifiable {
    let id: UUID
    let name: String
    let description: String
}

extension Photo: Comparable {
    static func < (lhs: Photo, rhs: Photo) -> Bool {
        lhs.name < rhs.name
    }
    
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}
