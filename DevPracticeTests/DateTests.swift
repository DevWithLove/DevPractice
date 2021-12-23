//
//  DateTests.swift
//  DevPracticeTests
//
//  Created by Tony Mu on 10/11/21.
//

import XCTest

class DateTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
  
    }

    func testConvertDateToString() throws {
        // Arrange
        let formatter = DateFormatter.ddMMMyyyDateFormatter
        let date = DateTestHelper.createDate(year: 2021, month: 01, day: 15)!
        // Act
        let string = formatter.string(from: date)
        
        // Assert
       XCTAssertEqual("15 Jan 2021", string)
    }
    
    func testConvertStringDate() throws {
        // Arrange
        let formatter = DateFormatter.ddMMMyyyDateFormatter
        let string = "15 Jan 2021"
        let expectedDate = DateTestHelper.createDate(year: 2021, month: 01, day: 15)!
        // Act
        let date = formatter.date(from: string)!
        
        // Assert
        let components = Calendar.current.dateComponents([.day, .year, .month], from: date)
        XCTAssertEqual(15, components.day)
        XCTAssertEqual(1, components.month)
        XCTAssertEqual(2021, components.year)
        XCTAssertEqual(date, expectedDate)
    }

    func testReferenceType() throws {
        let personA = Person(name: "A")
        let personB = personA
        personB.name = "B"
        print(personA.name)
        print(personB.name)
        
        
        updatePerson(person: personB)
        
        print(personA.name)
        print(personB.name)
    }
    
    func updatePerson(person: Person) {
        person.name = "updated name"
    }
}

class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
}
