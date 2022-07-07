//
//  BankManager.swift
//  BankManagerUIApp
//
//  Created by 이원빈 on 2022/07/07.
//

import Foundation

struct BankManager {
    var delegate: Showable?
    func handle(customer: Customer) {
        let customerNumber = customer.number
        let customerBusiness = customer.business
        
        print("\(customerNumber)번 고객 \(customerBusiness.name)업무 시작") // 업무중 뷰로 이동
        delegate?.startProcess(about: customer)
        Thread.sleep(forTimeInterval: customerBusiness.processTime)
        print("\(customerNumber)번 고객 \(customerBusiness.name)업무 완료") // 업무중 뷰에서 사라짐
        delegate?.endProcess(about: customer)
    }
}
