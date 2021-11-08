//
//  ListError.swift
//  DevPractice
//
//  Created by Tony Mu on 8/11/21.
//

import Foundation

enum ListError: Error {
    case loadListFailed
    case unableToSaveItem(item: Photo)
}

extension ListError {
    var localizedMessage: String {
        switch self {
        case .loadListFailed:
            return "To do load list failed message"
        case .unableToSaveItem(let photo):
            return "To do unable save the item message \(photo.id)"
        }
    }
}
