//
//  Customer.swift
//  BankManagerConsoleApp
//
//  Created by 예톤, 웡빙 on 2022/06/30.
//

struct Customer: Equatable {
    let number: Int
    let business: Business
    
    func generateLabel() -> String {
        return "\(number) - \(business.name)"
    }
}
