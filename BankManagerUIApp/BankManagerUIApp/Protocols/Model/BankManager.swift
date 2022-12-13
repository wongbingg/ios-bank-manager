//
//  BankManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

protocol BankManager {
    func handle(customer: Customer)
}
 
struct BankManagerImp: BankManager {
    weak var delegate: Workable?
    
    func handle(customer: Customer) {
        let processTime = customer.business.processTime
        delegate?.startProcess(about: customer)
        Thread.sleep(forTimeInterval: processTime)
        delegate?.endProcess(about: customer)
    }
}
