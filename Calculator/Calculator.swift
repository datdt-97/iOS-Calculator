//
//  Calculator.swift
//  Calculator
//
//  Created by Dang Thanh Dat on 8/2/19.
//  Copyright © 2019 Dang Thanh Dat. All rights reserved.
//

import Foundation

struct Calculator {

    var result: String? {
        get {
            return accumulator?.clean
        }
    }
    private var accumulator: Double?
    private var operations: [String: Operation] = [
        "×": Operation.binaryOperation({ $0 * $1 }),
        "÷": Operation.binaryOperation({ $0 / $1 }),
        "+": Operation.binaryOperation({ $0 + $1 }),
        "-": Operation.binaryOperation({ $0 - $1 }),
        "=": Operation.equals
    ]
    private var pendingBinaryOperation: PendingBinaryOperation?

    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .binaryOperation(let function):
                if let accumulator = accumulator {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator)
                    self.accumulator = nil
                }
                break
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }

    mutating func setOperand(_ operand: Double?) {
        accumulator = operand
    }

    private mutating func performPendingBinaryOperation() {
//        if pendingBinaryOperation != nil && accumulator != nil {
//            accumulator = pendingBinaryOperation?.perform(with: accumulator!)
//            pendingBinaryOperation = nil
//        }
        guard let pendingBinaryOperation = pendingBinaryOperation, let accumulator = accumulator else {
            return
        }
        self.accumulator = pendingBinaryOperation.perform(with: accumulator)
        self.pendingBinaryOperation = nil
    }

    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double

        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }

    private enum Operation {
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
}

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
