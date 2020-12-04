//
//  ViewController.swift
//  iOS4-LeDang-Pham
//
//  Created by Kim on 25.11.20.
//

import UIKit

class ViewController: UIViewController {
    
    var euro = 1.00
    var dollar = 1.1808
    var pound = 0.89183
    var euroToDollarRate = 1.1808
    var euroToPoundRate = 0.89183

    @IBOutlet weak var euroDollarRate: UITextField!
    @IBOutlet weak var euroPoundRate: UITextField!
    @IBOutlet weak var euroValue: UITextField!
    @IBOutlet weak var dollarValue: UITextField!
    @IBOutlet weak var poundValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getOnlineRate(_ sender: Any) {
    }
    
    @IBAction func dollarRateChanged(_ sender: Any) {
        euroToDollarRate = Double(euroDollarRate.text ?? "") ?? 0.0
        dollar = euro * euroToDollarRate
        dollarValue.text = doubleToString(doubleValue: dollar)
    }
    
    @IBAction func poundRateChanged(_ sender: Any) {
        euroToPoundRate = Double(euroPoundRate.text ?? "") ?? 0.0
        pound = euro * euroToPoundRate
        poundValue.text = doubleToString(doubleValue: pound)
    }
    
    @IBAction func euroValueChanged(_ sender: Any) {
        euro = Double(euroValue.text ?? "") ?? 0.0
        dollar = euro * euroToDollarRate
        pound = euro * euroToPoundRate
        dollarValue.text = doubleToString(doubleValue: dollar)
        poundValue.text = doubleToString(doubleValue: pound)
    }
    
    @IBAction func dollarValueChanged(_ sender: Any) {
        dollar = Double(dollarValue.text ?? "") ?? 0.0
        euro = dollar / euroToDollarRate
        pound = euro * euroToPoundRate
        euroValue.text = doubleToString(doubleValue: euro)
        poundValue.text = doubleToString(doubleValue: pound)
    }
    
    @IBAction func poundValueChanged(_ sender: Any) {
        pound = Double(poundValue.text ?? "") ?? 0.0
        euro = pound / euroToPoundRate
        dollar = euro * euroToDollarRate
        euroValue.text = doubleToString(doubleValue: euro)
        dollarValue.text = doubleToString(doubleValue: dollar)
    }
    
    func doubleToString(doubleValue: Double) -> String {
        return String(format: "%.2lf", doubleValue)
    }
}

