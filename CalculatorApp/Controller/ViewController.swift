//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Gokulraj Kumarassamy on 8/2/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    
    var calculatorLogic = CalculatorLogic()
    var operatorButtons : [UIButton]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        operatorButtons = [divideButton, multiplyButton, minusButton, addButton]
        updateDisplayLabel()
        // Do any additional setup after loading the view.
    }
  
    @IBAction func numButtonPressed(_ sender: UIButton) {
        calculatorLogic.updateDisplayText(num: sender.currentTitle!)
        updateDisplayLabel()
    }
    
    @IBAction func operatorButtonPressed(_ sender: UIButton) {
        resetOpButtons()
        sender.tintColor = .systemOrange
        sender.backgroundColor = .white
        calculatorLogic.createCalculation(op: sender.currentTitle!)
        updateDisplayLabel()
    }
    
    @IBAction func equalsButtonPressed(_ sender: UIButton) {
        resetOpButtons()
        calculatorLogic.solveCalculation()
        updateDisplayLabel()
    }
    
    @IBAction func singleNumOpButtonPressed(_ sender: UIButton) {
        calculatorLogic.unaryOpCalculation(op: sender.currentTitle!)
        updateDisplayLabel()
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        if calculatorLogic.clearCalculator(sender: sender) {
            resetOpButtons()
        }
        updateDisplayLabel()
    }
    
    func updateDisplayLabel() {
        calculatorLogic.formatDisplayText()
        calculatorLogic.displayAsInt()
        calculatorLogic.setClearButtonTitle(sender: clearButton)
        displayLabel.text = calculatorLogic.displayText
    }
    
    func resetOpButtons () {
        for button in operatorButtons! {
            button.tintColor = .white
            button.backgroundColor = .systemOrange
        }
    }
    
}

