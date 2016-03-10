//
//  Calculator.swift
//  PaceCalculator
//
//  Created by Rich Long on 10/03/2016.
//  Copyright © 2016 Rich Long. All rights reserved.
//

import Foundation

protocol Calculator {
    //    Speed = distance ÷ time m/s
    func getAverageSpeedResults(distance:Double, timeInSeconds:Double) -> Array<(String,Double)>
}

public class MetricCalculator:Calculator {
    
    public var distance:Double
    public var timeInSeconds:Double
    
    public init(distance:Double,timeInSeconds:Double) {
        self.distance = distance
        self.timeInSeconds = timeInSeconds
    }
    
    public func convertMinutesToSeconds(minutes:Int,seconds:Int) -> Int {
        return minutes * 60 + seconds;
    }
    
    public func getAverageSpeedResults(distance:Double, timeInSeconds:Double) -> Array<(String,Double)> {
        
        var distanceToCalc:Double
        var timeToCalc:Double
        
        if distance == 0 || timeInSeconds == 0 {
            distanceToCalc = self.distance
            timeToCalc = self.timeInSeconds
        }
        else {
            distanceToCalc = distance
            timeToCalc = timeInSeconds
        }
        
        let resultInKm = distanceToCalc / timeToCalc
        let resultInM = distanceToCalc / timeToCalc

        return [
            ("KM/s",resultInKm),
            ("M/s",resultInM)
        ]
    }
    
}

