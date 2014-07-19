//
//  ViewController.swift
//  TipCalculator
//
//  Created by Kushal Nigam on 7/19/14.
//  Copyright (c) 2014 Kushal Nigam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let tipCalc	= TipCalculatorModel(total: 0.0, taxPct: 0.07)
    
    @IBOutlet var totalTextField : UITextField
    @IBOutlet var taxPctSlider : UISlider
    @IBOutlet var taxPctLabel : UILabel
    @IBOutlet var resultsTextView : UITextView
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Button listener
    @IBAction func calculateTapped(sender : AnyObject){
        tipCalc.total = Double(totalTextField.text.bridgeToObjectiveC().doubleValue)
        let possibleTips = tipCalc.returnPossibleTips()
        var results = ""
        
        var tipPcts = Array(possibleTips.keys)
        sort(&tipPcts)
        for tipPct in tipPcts {
            let tipVal = possibleTips[tipPct]!
            let prettyTipVal = String(format:"%.2f", tipVal)
            let totalPrice = tipCalc.total + tipVal.bridgeToObjectiveC().doubleValue
            let prettyTotalPrice = String(format:"%.2f",totalPrice)
            results += "Tip \(tipPct)%: \(prettyTipVal)    Total: \(String(prettyTotalPrice))\n"
        }
        resultsTextView.text = results
    }
    
    //textbox onTouch listener
    @IBAction func totalTextBoxPressed(sender : AnyObject) {
        totalTextField.text = ""
        resultsTextView.text = ""
    }
    
    //slider listener
    @IBAction func taxPercentageChanged(sender : AnyObject) {
        tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
        tipCalc.total = Double(totalTextField.text.bridgeToObjectiveC().doubleValue)
        refreshUI()
    }
    
    //gesture/touch listener
    @IBAction func viewTapped(sender : AnyObject) {
        totalTextField.resignFirstResponder()
    }
    
    func refreshUI() {
        totalTextField.text = String(tipCalc.total)
        taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
        resultsTextView.text = ""
    }
}

