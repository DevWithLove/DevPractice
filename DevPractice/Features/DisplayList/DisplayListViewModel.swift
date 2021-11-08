//
//  DisplayListViewModel.swift
//  DevPractice
//
//  Created by Tony Mu on 8/11/21.
//

import Foundation

protocol DisplayListViewModelDelegate: AnyObject {
    func displayError(_ error: ListError)
    func didLoadData()
}

protocol DisplayListViewModelPortocol {
    var delegate: DisplayListViewModelDelegate? { get set }
    var items: [Photo] { get }
    func loadList()
    func safeItem()
}

class DisplayListViewModel: DisplayListViewModelPortocol {
    
    private let photoWebService: PhotoWebServiceProtocol
    
    weak var delegate: DisplayListViewModelDelegate?
    
    init(photoWebService: PhotoWebServiceProtocol = PhotoWebService()) {
        self.photoWebService = photoWebService
    }
    
    var items: [Photo] = []
    func loadList() {
        photoWebService.get { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photoDtos):
                self.items = photoDtos.compactMap { $0.toPhoto }
                self.delegate?.didLoadData()
            case .failure(_) :
                self.delegate?.displayError(.loadListFailed)
            }
        }
    }
    
    func safeItem() {
    }
}

extension PhotoDto {
    var toPhoto: Photo? {
        guard let title = author, let description = url else {
            return nil
        }
        return Photo(id: UUID(), name: title, description: description)
    }
}
