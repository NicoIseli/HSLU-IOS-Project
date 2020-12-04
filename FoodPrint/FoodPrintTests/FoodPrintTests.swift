//
//  FoodPrintTests.swift
//  FoodPrintTests
//
//  Created by nicock on 29.10.20.
//

import XCTest
@testable import FoodPrint

class FoodPrintTests: XCTestCase {
    
    
    
    
    
    // MARK: - PROVIDED FUNCTIONS BY TEST CLASS

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
    
    
    // MARK: - LOGIC TESTS
        
    // TEST TO CHECK WHETHER THERE IS A YEAR TRANSITION
    func testCheckForYearTransition(){
        // ARRANGE
        let noTransition1: [Int] = [1, 2, 11]
        let noTransition2: [Int] = [1]
        let noTransition3: [Int] = [1, 5, 10]
        
        let yesTransition1: [Int] = [1, 12]
        let yesTransition2: [Int] = [1, 5, 12]
        
        let plcv = ProductListViewController()
        
        // ACT
        let resultNoTransition1 = plcv.checkForYearTransition(months: noTransition1)
        let resultNoTransition2 = plcv.checkForYearTransition(months: noTransition2)
        let resultNoTransition3 = plcv.checkForYearTransition(months: noTransition3)
        
        let resultYesTransition1 = plcv.checkForYearTransition(months: yesTransition1)
        let resultYesTransition2 = plcv.checkForYearTransition(months: yesTransition2)
        
        // ASSERT
        XCTAssertFalse(resultNoTransition1)
        XCTAssertFalse(resultNoTransition2)
        XCTAssertFalse(resultNoTransition3)
        
        XCTAssertTrue(resultYesTransition1)
        XCTAssertTrue(resultYesTransition2)
    }
    
    // TEST THE SELECTION OF THE MONTHS WITH YEAR TRANSITION
    func testEvaluateDatesWithoutYearTransition(){
        // ARRANGE
        let noTransition1: [Int] = [1, 2, 3, 4, 5, 6]
        let noTransition2: [Int] = [3, 4, 5]
        let noTransition3: [Int] = [4, 8, 9]
        
        
        let plcv = ProductListViewController()
        
        // ACT
        let resultNoTransition1 = plcv.evaluateDatesWithoutYearTransition(months: noTransition1)
        let resultNoTransition2 = plcv.evaluateDatesWithoutYearTransition(months: noTransition2)
        let resultNoTransition3 = plcv.evaluateDatesWithoutYearTransition(months: noTransition3)
  
        
        // ASSERT
        XCTAssertEqual(resultNoTransition1.count, 2)
        XCTAssertEqual(resultNoTransition2.count, 2)
        XCTAssertEqual(resultNoTransition3.count, 2)
        
        XCTAssertEqual(1, resultNoTransition1[0])
        XCTAssertEqual(6, resultNoTransition1[1])
        
        XCTAssertEqual(3, resultNoTransition2[0])
        XCTAssertEqual(5, resultNoTransition2[1])
        
        XCTAssertEqual(4, resultNoTransition3[0])
        XCTAssertEqual(9, resultNoTransition3[1])
    }
    
    // TEST THE SELECTION OF THE MONTHS WITHOUT YEAR TRANSITION
    
    // TEST THE CALCULATION OF THE RATING
    
    // TEST THE RATING OF A PRODUCT
    
    

}
