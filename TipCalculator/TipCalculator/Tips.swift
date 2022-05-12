//
//  Tips.swift
//  TipCalculator
//
//  Created by Yusuke K on 2022-05-11.
//

import Foundation

struct Tips {
    var tipPercentage:Double
    var val: Double
    var totalAmount:Double {
        return val * (1 + tipPercentage/100.0)
    }
    
    init() {
        tipPercentage = 0.0
        val = 0.0
    }
    
    mutating func updatePercentage(percentage newVal:Double) {
        tipPercentage = newVal
    }
    
    mutating func updateVal(val newVal:Double) {
        val = newVal
    }
}
