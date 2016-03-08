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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let searchStrings = distanceTextField
//            .rac_textSignal()
//            .filter({ (String text) -> Bool in
//                return text.length > 3 ? true : false
//            })
//            .map({ (text) -> AnyObject! in
//                return isValidDistance(text)
//            })
//            .subscribeNext { (id x) -> Void in
//                print(x)
//        }
        
//        let searchStrings2 = timeTextField.rac_textSignal()
//            .toSignalProducer()
//            .map { text in text as! String}
//        
//        print(searchStrings)
//        print(searchStrings2)
//        
//        var distanceSignal:RACSignal = self.distanceTextField
//            .rac_textSignal()
//            .map { (id text) -> AnyObject! in
//                return isValidDistance(text)
//        }
        
        //
//        RACSignal *validUsernameSignal =
//            [self.usernameTextField.rac_textSignal
//                map:^id(NSString *text) {
//                return @([self isValidUsername:text]);
//                }];

        
//        [[validPasswordSignal
//            map:^id(NSNumber *passwordValid) {
//            return [passwordValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
//            }]
//            subscribeNext:^(UIColor *color) {
//            self.passwordTextField.backgroundColor = color;
//            }];
//        print(distanceSignal)
        
//        distanceSignal
//        .map { (text) -> Void! in
//            print(text)
//        }

//        [self.usernameTextField.rac_textSignal subscribeNext:^(id x) {
//            NSLog(@"%@", x);
//            }];


    }
    
    func isValidDistance(distance:String) -> Bool {
        print(distance)
        return  true
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
