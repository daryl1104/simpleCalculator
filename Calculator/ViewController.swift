//
//  ViewController.swift
//  Calculator
//
//  Created by daryl on 2023/5/8.
//

import UIKit

class ViewController: UIViewController {
    
    var currentOperator: Operator = .nothing
    var calculationState: CalculationState = .newNumStarted
    
    var firstNumber = ""
    var secondNumber = ""

    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func numbersTapped(_ sender: UIButton) {
        // update label to display
        updateDisplay(number: String(sender.tag))
    }
    
    func updateDisplay(number: String) {
        if calculationState == CalculationState.newNumStarted {
            calculationState = CalculationState.enteringNum
            resultLabel.text = number
        } else if(calculationState == CalculationState.enteringNum) {
            resultLabel.text = resultLabel.text! + number
        }
    }
    
    @IBAction func operatorsTapped(_ sender: UIButton) {
        calculationState = CalculationState.newNumStarted
        
        if resultLabel.text != "" {
            firstNumber = resultLabel.text!
            resultLabel.text = ""
        }
   
        switch sender.tag {
        case 10:
            currentOperator = .add
        case 11:
            currentOperator = .subtract
        case 12:
            currentOperator = .times
        case 13:
            currentOperator = .divide
            
        default:
            return
        }
        
    }
    
    @IBAction func equalTapped(_ sender: UIButton){
        var result = ""
        
        if resultLabel.text != "" {
            // 7 + 2 = 9
            // f   s   r
            if calculationState == .enteringNum {
                secondNumber = resultLabel.text!
            }
            else if calculationState == .newNumStarted {
                // secondNumber = secondNumber
            }
        }
        else {
            secondNumber = firstNumber
        }
        
        guard firstNumber != "" && secondNumber != "" else {
            return
        }
        
        switch currentOperator {
        case .add:
            result = "\(Double(firstNumber)! + Double(secondNumber)!)"

        case .subtract:
            result = "\(Double(firstNumber)! - Double(secondNumber)!)"
        case .times:
            result = "\(Double(firstNumber)! * Double(secondNumber)!)"
        case .divide:
            result = "\(Double(firstNumber)! / Double(secondNumber)!)"
        case .nothing:
            return
        }
        
        resultLabel.text = result
        firstNumber = result
        calculationState = CalculationState.newNumStarted
    }
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        resultLabel.text = ""
        calculationState = CalculationState.newNumStarted
        firstNumber = ""
        secondNumber = ""
    }

}

