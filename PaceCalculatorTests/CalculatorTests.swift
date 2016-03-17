//
//  CalculatorTests.swift
//  PaceCalculator
//
//  Created by Rich Long on 10/03/2016.
//  Copyright © 2016 Rich Long. All rights reserved.
//

import XCTest
import PaceCalculator

class MetricCalculatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitValuesSavedAndCanUpdate() {
        let calc = MetricCalculator()
        XCTAssert(calc.distance == 0)
        XCTAssert(calc.timeInSeconds == 0)
        calc.distance = 200
        calc.timeInSeconds = 200
        XCTAssert(calc.distance == 200)
        XCTAssert(calc.timeInSeconds == 200)
    }

    func testGetAverageSpeedResults() {
        let calc = MetricCalculator()
        let arr1 = calc.getAverageSpeedResults(0, timeInSeconds: 0)
        XCTAssert(arr1[0].title == MeasurementUnit.INVALID)
        XCTAssert(arr1[0].speed == -1)

        let arr2 = calc.getAverageSpeedResults(200, timeInSeconds: 100)
        XCTAssert(arr2[0].title == .KMPH)
        XCTAssert(arr2[0].speed == 7.2,"Err: \(arr2[0].speed)")
        XCTAssert(arr2[1].title == .MS)
        XCTAssert(arr2[1].speed == 2,"Err: \(arr2[0].speed)")
    }
    
    func testGetAverageSpeedResultZeroValues() {
        let calc = MetricCalculator()
        let arr1 = calc.getAverageSpeedResults(0, timeInSeconds: 0)
        XCTAssert(arr1[0].title == MeasurementUnit.INVALID)
        XCTAssert(arr1[0].speed == -1,"Err: \(arr1[0].speed)")
    }
    
    func testGetAverageSpeedResultMinusValues() {
        let calc = MetricCalculator()
        let arr1 = calc.getAverageSpeedResults(0, timeInSeconds: 0)
        XCTAssert(arr1[0].title == MeasurementUnit.INVALID)
        XCTAssert(arr1[0].speed == -1,"Err: \(arr1[0].speed)")
    }

}
