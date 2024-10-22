//
//  CalculatorLogic.swift
//  CalculatorApp
//
//  Created by Gokulraj Kumarassamy on 8/3/22.
//

import UIKit

struct CalculatorLogic {
    var displayText = "0"
    var num1 : Double?
    var num2: Double?
    var operation: String?
    var answerShown = false
    var displayValChanged = true
    var multiplierMode = false
    var multiplier = 0.0
    var opMultipler = ""
    
    mutating func updateDisplayText(num : String) {
        displayValChanged = true
        multiplierMode = false
        
        if (displayText == "0" && num != ".") || answerShown {
            displayText = num
            answerShown = false
            return
        }
        if displayText.count == 11 {
            return
        }
        if num == "." && displayText.contains(".") {
            return
        }
        
        displayText += num
    }
    
    mutating func createCalculation(op : String) {
        multiplierMode = false
        if num1 != nil {
            if !displayValChanged {
                operation = op
                return
            }
            solveCalculation()
            num1 = Double(displayText)
            operation = op
        } else {
            num1 = Double(displayText)
            operation = op
            displayText = "0"
            displayValChanged = false
        }
    }
    
    mutating func solveCalculation () {
        var result = 0.0
        num2 = Double(displayText)
        var n1 = num1 ?? 0.0
        var n2 = num2 ?? 0.0
        if !displayValChanged {
            n2 = n1
            multiplier = n1
            multiplierMode = true
            opMultipler = operation ?? "*"
            displayValChanged = true
        }
        else if multiplierMode {
            n1 = Double(displayText) ?? 0.0
            n2 = multiplier
            operation = opMultipler
        }
        switch operation {
        case "+":
            result = n1 + n2
        case "-":
            result = n1 - n2
        case "*":
            result = n1 * n2
        case "/":
            result = n1 / n2
        default:
            result = 0.0
        }
        displayText = String(result)
        answerShown = true
        resetValues()
    }
    
    mutating func unaryOpCalculation (op : String) {
        let num = Double(displayText)
        var result : Double
        if op == "pm" {result = (num ?? 0) * -1}
        else {result = (num ?? 0) * 0.01}
        displayText = String(result)
    }
    
    mutating func displayAsInt() {
        if displayText.hasSuffix(".0") {
            displayText = String(Int(Double(displayText) ?? 0))
        }
    }
    
    mutating func clearCalculator(sender : UIButton) -> Bool {
        answerShown = false
        if displayText == "0" {
            resetValues()
            sender.setTitle("AC", for: .normal)
            return true
        } else {
            displayText = "0"
            sender.setTitle("AC", for: .normal)
            return false
        }
        
    }
    
    func setClearButtonTitle (sender : UIButton) {
        if displayText != "0" {
            sender.setTitle("C", for: .normal)
        }
    }
    
    mutating func formatDisplayText () {
        if displayText.count > 10 {
        displayText = String(format: "%.10f", Double(displayText) ?? 0.0)
        }
    }
    
    mutating func resetValues () {
        num1 = nil
        num2 = nil
        operation = nil
    }
}
