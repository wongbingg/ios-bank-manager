//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by 예톤, 웡빙 on 2022/07/01.
//

import Foundation

struct Bank {
    var delegate: WorkProtocol?
    private var bankManager: BankManager
    var queue: CustomerQueue
    private let loanBusinessQueue = DispatchQueue(label: "loanQueue", attributes: .concurrent)
    private let depositBusinessQueue = DispatchQueue(label: "depositQueue", attributes: .concurrent)
    private(set) var countOfCustomer: Int = 1
    private var totalProcessTime: TimeInterval = 0
    private let group = DispatchGroup()
    private let loanSemaphore = DispatchSemaphore(value: 1)
    private let depositSemaphore = DispatchSemaphore(value: 2)
    
    init(employee bankManager: BankManager, customer queue: CustomerQueue) {
        self.bankManager = bankManager
        self.queue = queue
    }
    
    mutating func handleCustomer() {
        
        for _ in 0..<queue.count {
            putCustomerToSuitableQueue()
        }
        
        group.notify(queue: loanBusinessQueue) { [self] in
            delegate?.allWorkisFinished()
        }
    }
    
    private func putCustomerToSuitableQueue() {
        while let customer = queue.dequeue() {
            let depositWorkItem = makeWorkItem(for: customer, by: depositSemaphore)
            let loanWorkItem = makeWorkItem(for: customer, by: loanSemaphore)
            
            switch customer.business {
            case .loan:
                loanBusinessQueue.async(group: group, execute: loanWorkItem)
            case .deposit:
                depositBusinessQueue.async(group: group, execute: depositWorkItem)
            }
        }
    }
    
    private func makeWorkItem(for customer: Customer, by semaphore: DispatchSemaphore) -> DispatchWorkItem {
        let workItem = DispatchWorkItem { [self] in
            semaphore.wait()
            bankManager.handle(customer: customer)
            semaphore.signal()
        }
        
        return workItem
    }
}
