//
//  CalculatorBrain.swift
//  swift-calculator
//
//  Created by Guang on 1/31/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import Foundation

class CalulatorBrain
{
    private enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }
    
    private var opStack = [Op]()
    private var knownOps = [String:Op]()
    
    init(){
        knownOps["×"] = Op.BinaryOperation("×", * )
        knownOps["+"] = Op.BinaryOperation("+" , + )
        knownOps["÷"] = Op.BinaryOperation("÷"){ $1 / $1 }
        knownOps["-"] = Op.BinaryOperation("-"){ $1 - $0 }
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
        
    }
    
    private func evaluate(ops:[Op]) -> (result: Double?, remainingOps: [Op])
    {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_ , let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand),operandEvaluation.remainingOps)
                }
                
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evalutation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evalutation.result{
                        return (operation(operand1, operand2), op2Evalutation.remainingOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
    
     private func evaluate () -> Double? {
        let (result, _) = evaluate(opStack)
        return result
    }
    
    func pushOperand(operand: Double)
    {
        opStack.append(Op.Operand(operand))
    }
    
    func performOperation(symbol: String)
    {
        if let operation = knownOps[symbol]{
            opStack.append(operation)
        }
    }
    
}
