//
//  ViewController.swift
//  Calculator
//
//  Created by mohammed qasim on 24/02/2023.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlet for the calculator to display result
    @IBOutlet weak var calculatorLabel: UILabel!
    
    
    var operatorTag: Int? // tag is the operator button that was pressed
    var firstOperand: Double?
    var secondOperand: Double?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func numberChoose(_ sender: Any) {
        guard let tag = (sender as? UIButton)?.tag,
              let text = calculatorLabel.text else {
            
            return
            
        }
        
        
        
        if tag == 20 {
            
            if !text.contains(".") {
                calculatorLabel.text = text + "."
                
            }
            
        } else {
            
            if text == "0" {
                calculatorLabel.text = String(tag - 1)
                
            } else {
                calculatorLabel.text = text + String(tag - 1)
                
            }
            
        }
        
    }
    
    
    @IBAction func operatorChoose(_ sender: Any) {
        guard let tag = (sender as? UIButton)?.tag,
              
                let text = calculatorLabel.text else {
            
            return
            
        }
        
        if !text.isEmpty {
            firstOperand = Double(text)
            operatorTag = tag
            calculatorLabel.text = ""
            
        }
    }
    
    @IBAction func equalChoose(_ sender: Any) {
        
        guard let text = calculatorLabel.text,
              
                let opTag = operatorTag,
              let first = firstOperand,
              let second = Double(text) else {
            
            return
        }
        
        
        var result: Double = 0.0
        
        
        switch opTag {
        case 10:
            result = first + second
            
        case 11:
            result = first - second
            
        case 12:
            result = first * second
            
        case 13:
            result = first / second
            
        default:
            
            break
            
        }
        
        
        let resultString = String(result).trimmingCharacters(in: CharacterSet(charactersIn: ".0"))
        
        calculatorLabel.text = resultString
        firstOperand = nil
        operatorTag = nil
        
    }
    
    
    @IBAction func clearChoose(_ sender: Any) {
        
        calculatorLabel.text = "0"
        firstOperand = nil
        secondOperand = nil
        operatorTag = nil
        
    }
    
    
    @IBAction func percentChoose(_ sender: Any) {
        
        guard let text = calculatorLabel.text,
              let currentValue = Double(text) else {
            return
  
            
        }
        
        let result = currentValue / 100.0
        calculatorLabel.text = String(result)
        
        
    }
    
    
}


