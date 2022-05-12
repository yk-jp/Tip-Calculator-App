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
        registerForKeyboardNotification()
    }
    
    deinit {
       removeForKeyboardNotification()
    }
    
    
    @IBAction func calculateTips(_ sender: UIButton) {
        updateValue()
        updateLayout()
    }
    
    func registerForKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func removeForKeyboardNotification(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self,  name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self,  name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]) as? NSValue else {
            return
        }
        let keyboardFrame = keyboardRect.cgRectValue
        let keyboardSize = keyboardFrame.size
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
         view.frame.origin.y =  -keyboardSize.height
        } else {
            view.frame.origin.y = 0
        }
    }
    
    // dismissing keyboard by touching outside of keyboard
    // it is reacted even when keyboard is not shown up
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func updateValue() {
        guard billAmountTextField.text != nil, billAmountTextField.text != "" else {
            return
        }
        
        if let billAmountText = billAmountTextField.text {
            var newVal = Double(billAmountText)
            
            if newVal == nil {
                newVal = 0
            }
            
            tips.updateVal(val: newVal!)
        }
    }
    
    func updateLayout() {
        tipAmountLabel.text = String(format: "$%.2f", tips.totalAmount)
        tipPercentageTextField.text = String(format:"$%.2f", tips.tipPercentage) + " %" //e.g 0.21
    }
    
    // when return key is tapped
    //    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //        updateValue()
    //        updateLayout()
    //        textField.resignFirstResponder()
    //        return true
    //    }
}

