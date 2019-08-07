//
//  ViewController.swift
//  Calculator
//
//  Created by Dang Thanh Dat on 8/1/19.
//  Copyright © 2019 Dang Thanh Dat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var labelResult: UILabel!

    private var calculator = Calculator()
    private var isUserTyping = false
    private var displayValue: String? {
        get {
            return labelResult.text
        }
        set {
            labelResult.text = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func clickNumber(_ sender: BorderedButton) {
        guard let textCurrentlyDisplay = labelResult.text, let digit = sender.currentTitle else {
            return
        }
        if isUserTyping {
            labelResult.text = textCurrentlyDisplay + digit
        } else {
            labelResult.text = digit
            isUserTyping = true
        }
    }

    @IBAction func clickOperation(_ sender: BorderedButton) {
        if isUserTyping, let displayValue = displayValue {
            calculator.setOperand(Double(displayValue))
            isUserTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            calculator.performOperation(mathematicalSymbol)
        }
        if let result = calculator.result {
            displayValue = result
        }
    }

    @IBAction func clear(_ sender: Any) {
    }
}
