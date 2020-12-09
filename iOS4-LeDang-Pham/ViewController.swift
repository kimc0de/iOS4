//
//  ViewController.swift
//  iOS4-LeDang-Pham
//
//  Created by Kim on 25.11.20.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate{
    
    var defaultDollarRate = 1.1808
    var defaultPoundRate = 0.89183
    var defaultEuro = 1.0
    var defaultDollar = 1.18
    var defaultPound = 0.89
    var euroToDollarRate = 0.0
    var euroToPoundRate = 0.0
    var euro = 1.0
    var dollar = 1.18
    var pound = 0.89
   
    var sourceURL = "https://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml"


    @IBOutlet weak var euroDollarRate: UITextField!
    @IBOutlet weak var euroPoundRate: UITextField!
    @IBOutlet weak var euroValue: UITextField!
    @IBOutlet weak var dollarValue: UITextField!
    @IBOutlet weak var poundValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        euroDollarRate.delegate = self
        euroPoundRate.delegate = self
        euroValue.delegate = self
        dollarValue.delegate = self
        poundValue.delegate = self
        
        euroToDollarRate = defaultDollarRate
        euroToPoundRate = defaultPoundRate
        
        euroDollarRate.text = String(euroToDollarRate)
        euroPoundRate.text = String(euroToPoundRate)
        
        euroValue.text = doubleToString(doubleValue: defaultEuro)
        dollarValue.text = doubleToString(doubleValue: defaultDollar)
        poundValue.text = doubleToString(doubleValue: defaultPound)
        
    }

    @IBAction func buttonClicked(_ sender: Any) {
        setOnlineRate()
    }
    
    // Set online rate and update value of dolar and pound
    func setOnlineRate(){
        euroToDollarRate = getOnlineRate(currency: "USD")
        euroToPoundRate = getOnlineRate(currency: "GBP")
        
        euroDollarRate.text = String(euroToDollarRate)
        euroPoundRate.text = String(euroToPoundRate)
        
        //recalculate the currency values
        euro = Double(euroValue.text ?? "") ?? defaultEuro
        dollar = euro * euroToDollarRate
        pound = euro * euroToPoundRate
        dollarValue.text = doubleToString(doubleValue: dollar)
        poundValue.text = doubleToString(doubleValue: pound)
        
    }
    
    func getOnlineRate(currency: String) -> Double {
        let searchStart = "\"" + currency + "\" rate=\""
        let searchEnd = "\"/>"
        var foundCurrency: String = ""
        var defaultRate = 0.0
        
        if let url = URL(string: sourceURL) {
            do {
                let content = try String(contentsOf: url, encoding: .utf8)
                if let rangeStart = content.range(of: searchStart) {
                    let str = content[rangeStart.upperBound..<content.endIndex]
                    if let rangeEnd = str.range(of: searchEnd) {
                        foundCurrency = String(str[str.startIndex..<rangeEnd.lowerBound])
                    } else {
                        print("Failed to load \(currency)!")
                    }
                } else {
                    print("\(currency) not found!")
                }
            } catch {
                print("Failed to load content of URL")
            }
        } else {
            print("URL not valid")
        }
        
        if (currency == "USD") {
            defaultRate = defaultDollarRate
        } else if (currency == "GBP") {
            defaultRate = defaultPoundRate
        }
        return Double(foundCurrency) ?? defaultRate
    }
        
    // Rate € → $ on change -> update $ text field
    @IBAction func dollarRateChanged(_ sender: Any) {
        euroToDollarRate = Double(euroDollarRate.text ?? "") ?? defaultDollarRate
        dollar = euro * euroToDollarRate

        dollarValue.text = doubleToString(doubleValue:  dollar)

    }
    
    // Rate € → £ on change -> update  £ text field
    @IBAction func poundRateChanged(_ sender: Any) {
        euroToPoundRate = Double(euroPoundRate.text ?? "") ?? defaultPoundRate
        pound = euro * euroToPoundRate

        poundValue.text = doubleToString(doubleValue: pound)
    }
    
    // € text field changes -> update $ and £ text fields
    @IBAction func euroValueChanged(_ sender: Any) {
        euro = Double(euroValue.text ?? "") ?? defaultEuro
        dollar = euro * euroToDollarRate
        pound = euro * euroToPoundRate
        
        updateDisplay()
    }
    
    // $ text field changes -> update € and £ text fields
    @IBAction func dollarValueChanged(_ sender: Any) {
        dollar = Double(dollarValue.text ?? "") ?? defaultDollar
        euro = dollar / euroToDollarRate
        pound = euro * euroToPoundRate

        updateDisplay()
    }
    // £ text field changes -> update € and $ text fields
    @IBAction func poundValueChanged(_ sender: Any) {
        pound = Double(poundValue.text ?? "") ?? defaultPound
        euro = pound / euroToPoundRate
        dollar = euro * euroToDollarRate

        updateDisplay()
    }
    func updateDisplay(){
        euroValue.text = doubleToString(doubleValue: euro)
        dollarValue.text = doubleToString(doubleValue: dollar)
        poundValue.text = doubleToString(doubleValue: pound)
    }
    // Text field return by clicking enter
    // Keyboard disappear after return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true);
        textField.resignFirstResponder()
        return false
    }
    
    // Take a double value with 2 decimal places and convert to String
    func doubleToString(doubleValue: Double) -> String {
        return String(format: "%.2lf", doubleValue)
    }
    
}

