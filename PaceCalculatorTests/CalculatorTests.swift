//
//  CalculatorTests.swift
//  PaceCalculator
//
//  Created by Rich Long on 10/03/2016.
//  Copyright © 2016 Rich Long. All rights reserved.
//

import XCTest
import PaceCalculator

class CalculatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitValusSavedAndCanUpdate() {
        let calc = MetricCalculator(distance: 100,timeInSeconds: 100)
        XCTAssert(calc.distance == 100)
        XCTAssert(calc.timeInSeconds == 100)
        calc.distance = 200
        calc.timeInSeconds = 200
        XCTAssert(calc.distance == 200)
        XCTAssert(calc.timeInSeconds == 200)
    }
    
    func testConvertMinutesToSeconds() {
        let calc = MetricCalculator(distance: 100,timeInSeconds: 100)
         XCTAssert(calc.convertMinutesToSeconds(10, seconds: 10) == 610)
    }
    
    func testConvertMinutesToSecondsWithZeroValues() {
        let calc = MetricCalculator(distance: 100,timeInSeconds: 100)
        XCTAssert(calc.convertMinutesToSeconds(0, seconds: 0) == 0)
    }
    
    func testGetAverageSpeedResults() {
        let calc = MetricCalculator(distance: 100,timeInSeconds: 100)
        let arr1 = calc.getAverageSpeedResults(0, timeInSeconds: 0)
        XCTAssert(arr1[0].1 == 1)
        let arr2 = calc.getAverageSpeedResults(200, timeInSeconds: 100)
        XCTAssert(arr2[0].1 == 2)
    }
    
}
