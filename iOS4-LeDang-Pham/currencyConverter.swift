//
//  currencyConverter.swift
//  iOS4-LeDang-Pham
//
//  Created by Tùng Linh Phạm Bá on 02.12.20.
//

import Foundation
import UIKit

public class currencyConverter{
    var euro : Double = 1.00
    var usDollar : Double = 1.1808
    var pound : Double = 0.89183
    var euroToUsDollarRate = 1.1808
    var euroToPoundRate = 0.89183
    
    func euroToUsDollar(euro:Double) -> Double {
        return euro * euroToUsDollarRate
    }
    
    func euroToPound(euro:Double) -> Double {
        return euro * euroToPoundRate
    }
    
    func usDollarToEuro(usDollar:Double) -> Double {
        return usDollar / euroToUsDollarRate
    }
    
    func poundToEuro(pound:Double) -> Double {
        return pound / euroToPoundRate
    }
}
