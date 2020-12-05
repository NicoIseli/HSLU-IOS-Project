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
        let noTransition3: [Int] = [4, 5, 6, 7, 8, 9, 10, 11]
        
        
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
        XCTAssertEqual(11, resultNoTransition3[1])
    }
    
    // TEST THE SELECTION OF THE MONTHS WITHOUT YEAR TRANSITION
    func testEvaluateDatesWithYearTransition(){
        
        // ARRANGE
        let yesTransition1: [Int] = [1, 2, 10, 11, 12]
        let yesTransition2: [Int] = [1, 12]
        let yesTransition3: [Int] = [1, 2, 3, 12]
        
        let plcv = ProductListViewController()
        
        // ACT
        let resultYesTransition1 = plcv.evaluateDatesWithYearTransition(months: yesTransition1)
        let resultYesTransition2 = plcv.evaluateDatesWithYearTransition(months: yesTransition2)
        let resultYesTransition3 = plcv.evaluateDatesWithYearTransition(months: yesTransition3)
  
        
        // ASSERT
        XCTAssertEqual(resultYesTransition1.count, 2)
        XCTAssertEqual(resultYesTransition2.count, 2)
        XCTAssertEqual(resultYesTransition3.count, 2)
        
        XCTAssertEqual(10, resultYesTransition1[0])
        XCTAssertEqual(2, resultYesTransition1[1])
        
        XCTAssertEqual(12, resultYesTransition2[0])
        XCTAssertEqual(1, resultYesTransition2[1])
        
        XCTAssertEqual(12, resultYesTransition3[0])
        XCTAssertEqual(3, resultYesTransition3[1])
    }
    
    // TEST THE CALCULATION OF THE RATING
    func testCalculateRating(){
        
        /*
         CASES:
            WITH YEAR TRANSITION:
                - SEASONAL: PRODUCT IS FULL WITHIN SESONAL MONTH
                - NEAR SEASONAL: PRODUCT IS IN BORDER-MONTH
                - NEAR NOT SEASONAL: PRODUCT IS ONE MONTH OUTSIDE OF THE BORDER-MONTHS
                - NOT SEASONAL: PRODUCT IS MORE THAN ONE MONTH OUTSIDE THE BORDER-MONTHS
        
            WITHOUT YEAR TRANSITION:
                 - SEASONAL: PRODUCT IS FULL WITHIN SESONAL MONTH
                 - NEAR SEASONAL: PRODUCT IS IN BORDER-MONTH
                 - NEAR NOT SEASONAL: PRODUCT IS ONE MONTH OUTSIDE OF THE BORDER-MONTHS
                 - NOT SEASONAL: PRODUCT IS MORE THAN ONE MONTH OUTSIDE THE BORDER-MONTHS
         
            EXCEPTION CASES:
                - THERE IS NO YEAR TRANSITION BUT IT IS CURRENTLY DECEMBER AND THE START-DATE IS JANUARY. THIS SHOULD RESULT IN A RATING OF 1 WHICH MEANS THE PRODUCT IS NEARLY NOT SEASONAL.
         */
        
        
        
        /*
         * ARRANGE
         */
        
        // CASE: WITHOUT YEAR TRANSITION
        let currentMonthOctobre: Int = 10
        let currentMonthDecember: Int = 12
        
        let monthOctoberIsSeasonalWithoutYearTransition: [Int] = [9, 12]
        let monthOctoberIsNearSeasonalWithoutYearTransition: [Int] = [10, 11]
        let monthOctoberIsNearNotSeasonalWithoutYearTransition1: [Int] = [11, 12]
        let monthOctoberIsNearNotSeasonalWithoutYearTransition2: [Int] = [1, 9]
        let monthOctoberIsNotSeasonalWithoutYearTransition: [Int] = [4, 8]
        
        // CASE: WITH YEAR TRANSITION
        let monthOctoberIsSeasonalWithYearTransition: [Int] = [9, 3]
        let monthOctoberIsNearSeasonalWithYearTransition: [Int] = [10, 3]
        let monthOctoberIsNearNotSeasonalWithYearTransition: [Int] = [11, 3]
        let monthOctoberIsNotSeasonalWithYearTransition: [Int] = [12, 8]
        
        // CASE: WITHOUT YEAR TRANSITION
        let monthDecemberIsNearNotSeasonalWithoutYearTransition: [Int] = [1, 9]
        
        // CONSTANT OF PRODUCT LIST VIEW CONTROLLER
        let plcv = ProductListViewController()
        
        
        
        /*
         * ACT
         */
        
        // CHECK WITHOUT YEAR TRANSITION AND SEASONAL
        let seasonalWithoutYearTransition: Int = plcv.calculateRating(currentMonth: currentMonthOctobre, startMonth: monthOctoberIsSeasonalWithoutYearTransition[0], endMonth: monthOctoberIsSeasonalWithoutYearTransition[1], isTransitionYear: false)
        
        // CHECK WITHOUT YEAR TRANSITION AND NEAR SEASONAL
        let nearSeasonalWithoutYearTransition: Int = plcv.calculateRating(currentMonth: currentMonthOctobre, startMonth: monthOctoberIsNearSeasonalWithoutYearTransition[0], endMonth: monthOctoberIsNearSeasonalWithoutYearTransition[1], isTransitionYear: false)
        
        // CHECK WITHOUT YEAR TRANSITION AND NEAR NOT SEASONAL
        let nearNotSeasonalWithoutYearTransition1: Int = plcv.calculateRating(currentMonth: currentMonthOctobre, startMonth: monthOctoberIsNearNotSeasonalWithoutYearTransition1[0], endMonth: monthOctoberIsNearNotSeasonalWithoutYearTransition1[1], isTransitionYear: false)
        
        let nearNotSeasonalWithoutYearTransition2: Int = plcv.calculateRating(currentMonth: currentMonthOctobre, startMonth: monthOctoberIsNearNotSeasonalWithoutYearTransition2[0], endMonth: monthOctoberIsNearNotSeasonalWithoutYearTransition2[1], isTransitionYear: false)
        
        // CHECK WITHOUT YEAR TRANSITION AND NOT SEASONAL
        let notSeasonalWithoutYearTransition: Int = plcv.calculateRating(currentMonth: currentMonthOctobre, startMonth: monthOctoberIsNotSeasonalWithoutYearTransition[0], endMonth: monthOctoberIsNotSeasonalWithoutYearTransition[1], isTransitionYear: false)
        
        // CHECK WITH YEAR TRANSITION AND SEASONAL
        let seasonalWithYearTransition: Int = plcv.calculateRating(currentMonth: currentMonthOctobre, startMonth: monthOctoberIsSeasonalWithYearTransition[0], endMonth: monthOctoberIsSeasonalWithYearTransition[1], isTransitionYear: true)
        
        // CHECK WITH YEAR TRANSITION AND NEAR SEASONAL
        let nearSeasonalWithYearTransition: Int = plcv.calculateRating(currentMonth: currentMonthOctobre, startMonth: monthOctoberIsNearSeasonalWithYearTransition[0], endMonth: monthOctoberIsNearSeasonalWithYearTransition[1], isTransitionYear: true)
        
        // CHECK WITH YEAR TRANSITION AND NEAR NOT SEASONAL
        let nearNotSeasonalWithYearTransition: Int = plcv.calculateRating(currentMonth: currentMonthOctobre, startMonth: monthOctoberIsNearNotSeasonalWithYearTransition[0], endMonth: monthOctoberIsNearNotSeasonalWithYearTransition[1], isTransitionYear: true)
        
        // CHECK WITH YEAR TRANSITION AND NOT SEASONAL
        let notSeasonalWithYearTransition: Int = plcv.calculateRating(currentMonth: currentMonthOctobre, startMonth: monthOctoberIsNotSeasonalWithYearTransition[0], endMonth: monthOctoberIsNotSeasonalWithYearTransition[1], isTransitionYear: true)
        
        // CHECK WITHOUT YEAR TRANSITION BUT ITS DECEMBER AND STARTMONTH IS JANUARY
        let nearNotSeasonalWithoutYearTransition3: Int = plcv.calculateRating(currentMonth: currentMonthDecember, startMonth: monthDecemberIsNearNotSeasonalWithoutYearTransition[0], endMonth: monthDecemberIsNearNotSeasonalWithoutYearTransition[1], isTransitionYear: false)
    
        
        /*
         * ASSERT
         */
        
        // CHECK WITHOUT YEAR TRANSITION AND SEASONAL
        XCTAssertEqual(seasonalWithoutYearTransition, 3)
        
        // CHECK WITHOUT YEAR TRANSITION AND NEAR SEASONAL
        XCTAssertEqual(nearSeasonalWithoutYearTransition, 2)
        
        // CHECK WITHOUT YEAR TRANSITION AND NEAR NOT SEASONAL
        XCTAssertEqual(nearNotSeasonalWithoutYearTransition1, 1)
        XCTAssertEqual(nearNotSeasonalWithoutYearTransition2, 1)
        
        // CHECK WITHOUT YEAR TRANSITION AND NOT SEASONAL
        XCTAssertEqual(notSeasonalWithoutYearTransition, 0)
        
        // CHECK WITH YEAR TRANSITION AND SEASONAL
        XCTAssertEqual(seasonalWithYearTransition, 3)
        
        // CHECK WITH YEAR TRANSITION AND NEAR SEASONAL
        XCTAssertEqual(nearSeasonalWithYearTransition, 2)
        
        // CHECK WITH YEAR TRANSITION AND NEAR NOT SEASONAL
        XCTAssertEqual(nearNotSeasonalWithYearTransition, 1)
        
        // CHECK WITH YEAR TRANSITION AND NOT SEASONAL
        XCTAssertEqual(notSeasonalWithYearTransition, 0)
        
        // CHECK WITHOUT YEAR TRANSITION BUT ITS DECEMBER AND STARTMONTH IS JANUARY
        XCTAssertEqual(nearNotSeasonalWithoutYearTransition3, 1)
    }
}
