//
//  ViewController.swift
//  swift-calculator
//
//  Created by Guang on 1/30/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel! // optional initilized automatic for us/ set it earlier and stay set
    
    var userIsinTheMiddleOfTypingANumber : Bool = false // check for the first time of 0
    var brain = CalulatorBrain()
    
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

   // var operandStack = Array<Double>()
    
    @IBAction func operate(sender: UIButton) {
        
  //      let operation = sender.currentTitle!
        
        if userIsinTheMiddleOfTypingANumber {
            enter()
        }
        
        if let operation = sender.currentTitle {
            
            if let result = brain.performOperation(operation) {
                displayValue = result
            }else {
                displayValue = 0
            }
        }
    }
    
    
    func multiply(op1: Double, op2:Double) -> Double {
    
        return op1 * op2
        
    }

    @IBAction func enter( ) { // no need for argument
        
        userIsinTheMiddleOfTypingANumber = false
        
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
          //displayValue to be optional
            displayValue = 0 // should be nil
        }
        
        //print("operandStack = \(operandStack)")
    }
    
    @IBAction func clear() {
//        operandStack.removeAll()
//        userIsinTheMiddleOfTypingANumber = false
//        displayValue = 0
//
//        print("cleared operandStack = \(operandStack)")
        
    }
    
    
//    @IBAction func floatingPoint() {
////        userIsinTheMiddleOfTypingANumber = true
////        operandStack.append()
////        print("floatingPoint = \(operandStack)")
//    }
    
    
    
    
    var displayValue: Double{
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
          display.text = "\(newValue)"
            userIsinTheMiddleOfTypingANumber = false
        }
    }
}

