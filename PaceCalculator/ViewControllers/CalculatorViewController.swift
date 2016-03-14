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
    
    var totalDistance:Double? = 0
    var totalTimeInSeconds:Double? = 0
    var timeInSeconds:Double? = 0
    var timeInMinutes:Double? = 0
    var timeInHours:Double? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let calc = MetricCalculator(distance: 100,timeInSeconds: 100)
        
        distanceTextField.rac_textSignal()
            .filter({ (id input) -> Bool in
                return input.length > 0 ? true : false
            })
            .subscribeNext {
            (next:AnyObject!) -> () in
                if let distance:Double = next.doubleValue {
                    if distance > 0 {
                        print("distance: ",distance)
                    }
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
                    if next.doubleValue >= 0 {
                        self.timeInSeconds? = next.doubleValue
                        self.secondsTextField.backgroundColor = UIColor .whiteColor()
                    }
                    else {
                        self.timeInHours? = 0;
                        self.secondsTextField.backgroundColor = UIColor .redColor()
                    }
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
                    if next.doubleValue >= 0 {
                        self.timeInMinutes? = next.doubleValue
                        self.minutesTextField.backgroundColor = UIColor .whiteColor()
                    }
                    else {
                        self.timeInHours? = 0;
                        self.minutesTextField.backgroundColor = UIColor .redColor()
                    }
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
                    if next.doubleValue >= 0 {
                        self.timeInHours? = next.doubleValue
                        self.hoursTextField.backgroundColor = UIColor .whiteColor()
                    }
                    else {
                        self.timeInHours? = 0;
                        self.hoursTextField.backgroundColor = UIColor .redColor()
                    }
                }
                else {
                    self.timeInHours? = 0;
                    self.hoursTextField.backgroundColor = UIColor .redColor()
                }
                self.calculateTimeInSeconds()
            }
    }
    
    func isValidDistance(distance:String) -> Bool {
        return  true
    }
    
    func isValidInput(input:String) -> Bool {
        //Checks regex for chars, if found then returns as invalid.
        //Regex frame work doesn't appear to work when looking for 0-9
        let result = input.grep("([A-Za-z])")
        return result.boolValue ? false : true
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
    }
    

}
