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
    func getAverageSpeedResults(distance:Double, timeInSeconds:Double) -> Array<(title:MeasurementUnit,speed:Double)>
}

public enum MeasurementUnit:String {
    case INVALID = "INVALID"
    case KMPH = "KMPH"
    case MS = "MS"
    case MPH = "MPH"
    case FPS = "FPS"
}

public class MetricCalculator:Calculator {
    
    public var distance:Double?
    public var timeInSeconds:Double?
    
    public init() {
        self.distance = 0;
        self.timeInSeconds = 0;
    }

    public func getAverageSpeedResults(distance:Double, timeInSeconds:Double) -> Array<(title:MeasurementUnit,speed:Double)> {
        
        guard (distance > 0 || timeInSeconds > 0) else {
            return[(.INVALID,-1)]
        }
        
        if let resultInMeters:Double = distance / timeInSeconds {
            
            print("d",distance,"t",timeInSeconds, "res",resultInMeters)
            
            return [
                (.KMPH,resultInMeters.convertMsToKmh()),
                (.MS,resultInMeters.roundToPlaces(2))
            ]
        }
        else {
            return[(.INVALID,-1)]
        }
    }    

}

extension Double {
    /// Rounds the double to decimal places value
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
    
    func convertMsToKmh() -> Double{
        return (self * 3600 / 1000).roundToPlaces(2)
    }
    
    func convertKmhToMs() -> Double{
        return (self / 3600 * 1000).roundToPlaces(2)
    }

}


