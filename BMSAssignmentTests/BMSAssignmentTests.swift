//
//  BMSAssignmentTests.swift
//  BMSAssignmentTests
//
//  Created by Lovina Vijay Hajirawala on 24/05/21.
//

import XCTest
@testable import BMSAssignment

class BMSAssignmentTests: XCTestCase {

    let movieList : MovieListResponse! = nil
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDataSource(){
        let testcase = TestCases()
        // update empty state
        XCTAssertEqual(testcase.getMovieData(movieName: "3 idiots", isAdult: false ), "movie name :3 idiots & Adult: false")
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
