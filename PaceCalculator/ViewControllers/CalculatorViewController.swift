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

class CalculatorViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var secondsTextField: UITextField!
    @IBOutlet weak var minutesTextField: UITextField!
    @IBOutlet weak var hoursTextField: UITextField!
    @IBOutlet weak var unitSegmentedControl: UISegmentedControl!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var unitSegWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var pickerView: UIPickerView!
    var totalDistance:Double? = 0
    var totalTimeInSeconds:Double? = 0
    var timeInSeconds:Double? = 0
    var timeInMinutes:Double? = 0
    var timeInHours:Double? = 0
    var unitCalculator:Calculator? = MetricCalculator()
    var activeUnit:MeasurementUnit? = MeasurementUnit.KMPH
    var metricPickerData = ["5k","10k","15k","21.1km","25k","42.2k"]
    var imperialPickerData = ["5 Miles","10 Miles","15 Miles","25 Miles","50 Miles","100 Miles"]
    var isUsingMetric = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObserversToTextFields()
        
        // Connect data:
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        _mainView.datePicker.rac_signalForControlEvents(.ValueChanged).toSignalProducer().startWithNext { (x) -> () in
            guard let datePicker = x as? UIDatePicker else { return }
            print("\(datePicker.date)")
        }

        
        let action = #selector(pickerView.tappedButton)

        let sel:Selector = "UIControlEventValueChanged:"

        pickerView.r
            .subscribeNext {
                (next:AnyObject!) -> () in
                
                print("dsfd'")
        }

    }
    
    func setPickerViewData() {
        
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return self.isUsingMetric ?  self.metricPickerData.count :  self.imperialPickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.isUsingMetric ?  self.metricPickerData[row] :  self.imperialPickerData[row]
    }

    
    func addObserversToTextFields() {
        // Add observer for distance textFields
        distanceTextField.rac_textSignal()
            .subscribeNext {
                (next:AnyObject!) -> () in
                if self.isValidInput(next as! String) {
                    self.totalDistance? = next.doubleValue
                    self.distanceTextField.backgroundColor = UIColor .whiteColor()
                    print(self.totalDistance)
                    self.outputConversion()
                }
                else {
                    self.totalDistance? = 0;
                    self.distanceTextField.backgroundColor = UIColor .redColor()
                }
        }
        
        // Add observers for time textFields
        
        secondsTextField.rac_textSignal()
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
    
    @IBAction func changeMeasurementSystem(sender: UISegmentedControl) {
        
        var segControlWidth:CGFloat = 180
        
        //Toggle boolean
        self.isUsingMetric = self.isUsingMetric ? false : true

        switch sender.selectedSegmentIndex {
        case 0:
            self.unitCalculator = MetricCalculator()
            self.unitSegmentedControl.setTitle("Meters", forSegmentAtIndex: 0)
            self.unitSegmentedControl.setTitle("Kilometers", forSegmentAtIndex: 1)

        case 1:
            self.unitCalculator = ImperialCalculator()
            segControlWidth = 150;
            self.unitSegmentedControl.setTitle("Yards", forSegmentAtIndex: 0)
            self.unitSegmentedControl.setTitle("Miles", forSegmentAtIndex: 1)

        default:
            self.unitCalculator = MetricCalculator()
        }
        self.calculateTimeInSeconds()
        
        self.view.layoutIfNeeded()
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.unitSegWidthConstraint.constant = segControlWidth;
            self.view.layoutIfNeeded()
            }) { (finished) -> Void in
                print("done")
        }

        
    }
    
    @IBAction func changeMeasurementUnit(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.activeUnit = MeasurementUnit.MS
        case 1:
            self.activeUnit = MeasurementUnit.KMPH
        default:
            self.activeUnit = MeasurementUnit.INVALID
        }
        calculateTimeInSeconds()
        
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
        
        if input.characters.count == 0 {
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
        self.outputConversion()
    }
    
    func outputConversion() {
        
        var textOutput = "Enter time and distance above"
        var distanceToConvert = self.totalDistance
        if self.activeUnit == MeasurementUnit.KMPH {
            distanceToConvert = self.totalDistance! * 1000
        }
        
        if self.totalTimeInSeconds > 0 && self.totalDistance > 0 {
            //This gets array of results from unit calculator and filters only the current active unit, swift is impressive
            if let result = self.unitCalculator?.getAverageSpeedResults(distanceToConvert!, timeInSeconds: self.totalTimeInSeconds!).filter({$0.title == self.activeUnit}) {
                
                textOutput = String(result[0].speed,result[0].title.rawValue)
                
            }
            else {
                textOutput = "Invalid input - check and try again"
            }
        }
        
        self.resultLabel.text = textOutput
        
    }

}
