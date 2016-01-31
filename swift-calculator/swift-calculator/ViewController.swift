//
//  ViewController.swift
//  swift-calculator
//
//  Created by Guang on 1/30/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsinTheMiddleOfTypingANumber : Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsinTheMiddleOfTypingANumber {
            display.text = display.text! + digit}
        else {
         display.text = digit
            userIsinTheMiddleOfTypingANumber = true
        }
        print("digit = \(digit)")
    }
}

