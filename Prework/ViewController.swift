//
//  ViewController.swift
//  Prework
//
//  Created by Chandana Pemmasani on 7/8/21.
//

import UIKit

//protocol tipDel {
//    func tipDelegate(_ tip: Double)
//}

class ViewController: UIViewController {

    
    @IBOutlet weak var billAmountTextField: UITextField!
    
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    
    @IBOutlet weak var stepLbl: UILabel!
    
    var constantTip = [0.15, 0.18, 0.2]
    var tipSelected = 0.15
    
    
    override func viewDidLoad() {
       
            super.viewDidLoad()
            self.title = "Tip Calculator"
        overrideUserInterfaceStyle = .light
        billAmountTextField.becomeFirstResponder()
        if let bill = UserDefaults.standard.object(forKey: "bill") as? Double {

            billAmountTextField.text = String(bill)
        }
        
    }
    
//    func tipDelegate(_ tip: Double) {
//        customTip = tip
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if let selColo = UserDefaults.standard.color(forKey: "color") {
          self.view.backgroundColor = selColo
       }

        var changeTip = 0.0
        if let selectedTip = UserDefaults.standard.object(forKey: "tip") as? Double {
            
            if selectedTip < 1 {
                changeTip = selectedTip * 100
                   }
            else {
                changeTip = selectedTip
            }
            tipControl.setTitle("\(Int(changeTip))%" , forSegmentAt: 2)
            constantTip[2] = selectedTip
        }
        
    }

    @IBAction func stepper(_ sender: UIStepper) {
        

        stepLbl.text = String(format: "%.\(0)f", sender.value)
        
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        if let selectedTip = UserDefaults.standard.object(forKey: "tip") as? Double {
            
            constantTip[2] = selectedTip
        }
        tipSelected = constantTip[tipControl.selectedSegmentIndex]
       
    }
    
    @IBAction func applyBtn(_ sender: Any) {
        
        let bill = Double(billAmountTextField.text!) ?? 0
        UserDefaults.standard.set(bill , forKey: "bill")
        if tipSelected > 1 {
            tipSelected = tipSelected/100
        }
        let tip = bill * tipSelected
        let numPpl = Double(stepLbl.text!) ?? 1
        let total = (bill + tip)/numPpl
       
        var currencySymbol = "$"
        if let selectedCurrency = UserDefaults.standard.object(forKey: "currency") as? String {
            
            currencySymbol = selectedCurrency
        }
            tipAmountLabel.text = String(format: "\(currencySymbol)%.2f", tip)
            totalLabel.text = String(format: "\(currencySymbol)%.2f", total)
        
    }
    
}

