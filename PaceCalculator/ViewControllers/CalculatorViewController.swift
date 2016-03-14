//
//  CalculatorViewController.swift
//  PaceCalculator
//
//  Created by Rich Long on 08/03/2016.
//  Copyright © 2016 Rich Long. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Regex

class CalculatorViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var secondsTextField: UITextField!
    @IBOutlet weak var minutesTextField: UITextField!
    @IBOutlet weak var hoursTextField: UITextField!
    @IBOutlet weak var unitSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var totalDistance:Double? = 0
    var totalTimeInSeconds:Double? = 0
    var timeInSeconds:Double? = 0
    var timeInMinutes:Double? = 0
    var timeInHours:Double? = 0
    var unitCalculator:Calculator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add observer for distance textFields
        distanceTextField.rac_textSignal()
            .filter({ (id input) -> Bool in
                return input.length > 0 ? true : false
            })
            .subscribeNext {
            (next:AnyObject!) -> () in
                if self.isValidInput(next as! String) {
                    self.totalDistance? = next.doubleValue
                    self.distanceTextField.backgroundColor = UIColor .whiteColor()
                }
                else {
                    self.totalDistance? = 0;
                    self.distanceTextField.backgroundColor = UIColor .redColor()
                }
            }
        
        // Add observers for time textFields
        
        secondsTextField.rac_textSignal()
            .filter({ (id input) -> Bool in
                return input.length > 0 ? true : false
            })
            .subscribeNext {
                (next:AnyObject!) -> () in
                
                if self.isValidInput(next as! String) {
                    self.timeInSeconds? = next.doubleValue
                    self.secondsTextField.backgroundColor = UIColor .whiteColor()
                }
                else {
                    self.timeInHours? = 0;
                    self.secondsTextField.backgroundColor = UIColor .redColor()
                }
                self.calculateTimeInSeconds()
            }
        
        minutesTextField.rac_textSignal()
            .filter({ (id input) -> Bool in
                return input.length > 0 ? true : false
            })
            .subscribeNext {
                (next:AnyObject!) -> () in
                
                if self.isValidInput(next as! String) {
                    self.timeInMinutes? = next.doubleValue
                    self.minutesTextField.backgroundColor = UIColor .whiteColor()
                }
                else {
                    self.timeInHours? = 0;
                    self.minutesTextField.backgroundColor = UIColor .redColor()
                }
                self.calculateTimeInSeconds()

            }
        
        hoursTextField.rac_textSignal()
            .filter({ (String input) -> Bool in
                return input.length > 0 ? true : false
            })
            .map { text in text as! String }
            .subscribeNext { (next:AnyObject!) -> () in
                
                if self.isValidInput(next as! String) {
                    self.timeInHours? = next.doubleValue
                    self.hoursTextField.backgroundColor = UIColor .whiteColor()
                }
                else {
                    self.timeInHours? = 0;
                    self.hoursTextField.backgroundColor = UIColor .redColor()
                }
                self.calculateTimeInSeconds()
            }
    }
    
    
    func isValidInput(input:String) -> Bool {
        //Checks regex for chars, if found then returns as invalid.
        //Regex framework doesn't appear to work when looking for 0-9
        let result = input.grep("([A-Za-z])")
        if result.boolValue {
            return false
        }
        
        if Double(input) >= 0 {
            return true
        }
        
        return false
    }
    
    func calculateTimeInSeconds() {
        
        self.totalTimeInSeconds? = 0;
        
        if let hoursToSeconds:Double = self.timeInHours! * 60 * 60 {
            self.totalTimeInSeconds = self.totalTimeInSeconds! + hoursToSeconds
        }
        
        if let minutesToSeconds:Double = self.timeInMinutes! * 60{
            self.totalTimeInSeconds = self.totalTimeInSeconds! + minutesToSeconds
        }
        
        if let hoursToSeconds:Double = self.timeInSeconds!{
            self.totalTimeInSeconds = self.totalTimeInSeconds! + hoursToSeconds
        }
        print(self.totalTimeInSeconds)
        self.outputConversion()
    }
    
    func outputConversion() {
        
        if self.totalTimeInSeconds > 0 && self.totalDistance > 0 {
            
            self.unitCalculator = MetricCalculator(distance: self.totalDistance!, timeInSeconds: self.totalTimeInSeconds!)
            if let result = self.unitCalculator?.getAverageSpeedResults(self.totalDistance!, timeInSeconds: self.timeInSeconds!) {
                
                self.resultLabel.text = String(result[0].speed,result[0].title.rawValue)
                print(result[0])
                
            }
        }
        
    }

}
