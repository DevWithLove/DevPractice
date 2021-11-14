//
//  ArraySortingTesting.swift
//  DevPracticeTests
//
//  Created by Tony Mu on 9/11/21.
//

import XCTest

class ArraySortingTesting: XCTestCase {

    func testBubbleSorting() throws {
        // Arrange
        let data = [1,3,5,6,2,1,0,9,2]
        
        // Act
        let sorted = data.bubbleSort()
        
        // Assert
        print(sorted)
        XCTAssertEqual(0, sorted.first)
        XCTAssertEqual(9, sorted.last)
    }
    
    func testBubbleSorting_object() throws {
        // Arrange
        let data = [Car(name: "AA"), Car(name: "BB"), Car(name: "A2"), Car(name: "C2"), Car(name: "De")]
        
        // Act
        let sorted = data.bubbleSort()
        
        // Assert
        print(sorted)
        XCTAssertEqual("A2", sorted.first?.name)
        XCTAssertEqual("De", sorted.last?.name)
    }
    
    func testInsertionSorting() throws {
        // Arrange
        let data = [1,3,2,0]
        
        // Act
        let sorted = data.insertionSort()
        
        // Assert
        print(sorted)
        XCTAssertEqual(0, sorted.first)
        XCTAssertEqual(3, sorted.last)
    }
    
    func testSelectionSorting() throws {
        // Arrange
        let data = [1,3,2,0]
        
        // Act
        let sorted = data.selectionSort()
        
        // Assert
        print(sorted)
        XCTAssertEqual(0, sorted.first)
        XCTAssertEqual(3, sorted.last)
    }
    
    func testQuickSorting() throws {
        // Arrange
        let data = [1,3,2,0]
        
        // Act
        let sorted = data.quickSort()
        
        // Assert
        print(sorted)
        XCTAssertEqual(0, sorted.first)
        XCTAssertEqual(3, sorted.last)
    }
    
    func testQuickSorting2() throws {
        // Arrange
        let data = [1,3,2,0]
        
        // Act
        let sorted = data.quickSort2()
        
        // Assert
        print(sorted)
        XCTAssertEqual(0, sorted.first)
        XCTAssertEqual(3, sorted.last)
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        let array = Array.generateUniqueRandomNumber(size: 10000)
        self.measure {
            _ = array.quickSort2()
        }
    }
}

struct Car: Comparable {
    let name: String
    
    static func < (lhs: Car, rhs: Car) -> Bool {
        lhs.name < rhs.name
    }
}
