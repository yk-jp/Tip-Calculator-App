//
//  ViewController.swift
//  TipCalculator
//
//  Created by Yusuke K on 2022-05-10.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var tips: Tips = Tips()
    
    @IBOutlet var billAmountTextField: UITextField!
    @IBOutlet var tipAmountLabel: UILabel!
    @IBOutlet var tipPercentageTextField: UILabel!
    
    @IBAction func adjustTipPercentage(_ sender: UISlider) {
        let newPercentage = sender.value
        tips.updatePercentage(percentage: Double(newPercentage))
        updateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hook up billAmountTextField to the view controller
//        billAmountTextField.delegate = self
        updateLayout()
    }
    
    
    @IBAction func calculateTips(_ sender: UIButton) {
        updateValue()
        updateLayout()
    }
    
    // when return key is tapped
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        updateValue()
//        updateLayout()
//        textField.resignFirstResponder()
//        return true
//    }
    
    // dismissing keyboard by touching outside of keyboard
    // it is reacted even when keyboard is not shown up
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func updateValue() {
        guard billAmountTextField.text != nil else {
            return
        }
        
        if let billAmountText = billAmountTextField.text {
            let newVal = Double(billAmountText)
            tips.updateVal(val: newVal!)
        }
    }
    
    func updateLayout() {
        tipAmountLabel.text = String(format: "$%.2f", tips.totalAmount)
        tipPercentageTextField.text = String(format:"$%.2f", tips.tipPercentage) + " %" //e.g 0.21
    }
}

