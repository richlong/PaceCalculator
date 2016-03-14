//
//  CalculatorViewController.swift
//  PaceCalculator
//
//  Created by Rich Long on 08/03/2016.
//  Copyright © 2016 Rich Long. All rights reserved.
//

import UIKit
import ReactiveCocoa

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
        
        let calc = MetricCalculator(distance: 100,timeInSeconds: 100)
        
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
        
        secondsTextField.rac_textSignal()
            .filter({ (id input) -> Bool in
                return input.length > 0 ? true : false
            })
            .subscribeNext {
                (next:AnyObject!) -> () in
                if let seconds:Double = next.doubleValue {
                    if seconds > 0 {
                        self.timeInSeconds? = seconds
                    }
                    else {
                        self.timeInSeconds? = 0;
                    }
                }
                else {
                    self.timeInSeconds? = 0;
                }
                self.calculateTimeInSeconds()
            }
        
        minutesTextField.rac_textSignal()
            .filter({ (id input) -> Bool in
                return input.length > 0 ? true : false
            })
            .subscribeNext {
                (next:AnyObject!) -> () in
                if let minutes:Double = next.doubleValue {
                    if minutes > 0 {
                        self.timeInMinutes? = minutes
                    }
                    else {
                        self.timeInMinutes? = 0;
                    }
                }
                else {
                    self.timeInMinutes? = 0;
                }
                self.calculateTimeInSeconds()
            }
        
        hoursTextField.rac_textSignal()
            .filter({ (id input) -> Bool in
                return input.length > 0 ? true : false
            })
            .subscribeNext {
                (next:AnyObject!) -> () in
                if let hours:Double = next.doubleValue {
                    if hours > 0 {
                        self.timeInHours? = hours
                    }
                    else {
                        self.timeInHours? = 0;
                    }
                }
                else {
                    self.timeInHours? = 0;
                }
                self.calculateTimeInSeconds()
        }        
    }
    
    func isValidDistance(distance:String) -> Bool {
        return  true
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
