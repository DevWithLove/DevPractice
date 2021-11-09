//
//  PhotoListViewModelTests.swift
//  DevPracticeTests
//
//  Created by Tony Mu on 8/11/21.
//

import XCTest
@testable import DevPractice

class PhotoListViewModelTests: XCTestCase {
    
    let timeout: TimeInterval = 5
    var testExpectation: XCTestExpectation?
    
    override func setUp() {
        testExpectation = self.expectation(description: "CallBack")
    }
    
    func testLoadDataSuccess() throws {
        
        // Arrange
        let mockWebService = MockWebServcie(expectedResult: .success([PhotoDto(id: "1", author: "AestPhoto1", url: "Test photo1 description"),
                                                                      PhotoDto(id: "2", author: "BestPhoto2", url: "Test photo2 description"),
                                                                      PhotoDto(id: "3", author: "AestPhoto2", url: "Test photo2 description")]))
        let view = MockListViewController(testExpection: testExpectation!)
        let viewModel = DisplayListViewModel(photoWebService: mockWebService)
        viewModel.delegate = view
        
        // Act
        viewModel.loadList()
        
        // Assert
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertTrue(view.isDataLoaded)
        XCTAssertNil(view.errorMessage)
        XCTAssertEqual(viewModel.items[0].name, "AestPhoto1")
        XCTAssertEqual(viewModel.items[1].name, "AestPhoto2")
        XCTAssertEqual(viewModel.items[2].name, "BestPhoto2")
    }
    
    func testLoadDataFailed() throws {
        
        // Arrange
        let mockWebService = MockWebServcie(expectedResult: .failure(.notFound))
        let view = MockListViewController(testExpection: testExpectation!)
        let viewModel = DisplayListViewModel(photoWebService: mockWebService)
        viewModel.delegate = view
        
        // Act
        viewModel.loadList()
        
        // Assert
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertTrue(viewModel.items.isEmpty)
        XCTAssertFalse(view.isDataLoaded)
        XCTAssertEqual(view.errorMessage, "To do load list failed message")
    }
}

class MockWebServcie: PhotoWebServiceProtocol {
    typealias PhotoServicesMockResult = Result<[PhotoDto], ApiError>
    private let expectedResult: PhotoServicesMockResult
    
    init(expectedResult: PhotoServicesMockResult) {
        self.expectedResult = expectedResult
    }
    
    func get(completion: @escaping PhotoWebServiceResult) {
        completion(expectedResult)
    }
}

class MockListViewController: DisplayListViewModelDelegate {
    private let testExpection: XCTestExpectation
    
    public private(set) var isDataLoaded: Bool = false
    public private(set) var errorMessage: String? = nil
    
    init(testExpection: XCTestExpectation) {
        self.testExpection = testExpection
    }
    
    func displayError(_ error: ListError) {
        errorMessage = error.localizedMessage
        testExpection.fulfill()
    }
    
    func didLoadData() {
        isDataLoaded = true
        testExpection.fulfill()
    }
}
