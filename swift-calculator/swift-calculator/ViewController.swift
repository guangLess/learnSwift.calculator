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

    var operandStack = Array<Double>()
    
    @IBAction func operate(sender: UIButton) {
        
        let operation = sender.currentTitle!
        
        if userIsinTheMiddleOfTypingANumber {
            
            enter()
        }
        
        switch operation {
            
        case "×": performOperation { $0 * $1 } // if there is not agument {} goes outside
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "√": performOperation1 {sqrt($0)}

        default : break
        }
    }
    
    func performOperation(operation:(Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    
    func performOperation1(operation: Double -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    
    
    func multiply(op1: Double, op2:Double) -> Double {
    
        return op1 * op2
        
    }

    @IBAction func enter( ) { // no need for argument
        
        userIsinTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }
    
    @IBAction func clear() {
        operandStack.removeAll()
        userIsinTheMiddleOfTypingANumber = false
        displayValue = 0

        print("cleared operandStack = \(operandStack)")

        
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

