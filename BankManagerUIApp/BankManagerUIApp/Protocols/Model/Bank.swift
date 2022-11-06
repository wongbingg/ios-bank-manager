//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by 예톤, 웡빙 on 2022/07/01.
//

import Foundation

protocol Bank {
    func addTenCustomer()
    func handleCustomer()
    func resetCustomer()
    func bindUI(_ completion: @escaping ([Customer?]) -> Void)
}

final class BankImp: Bank {
    
    // MARK: - Properties
    private let delegate: Workable
    private let queue = CustomerQueue()
    private var bankManager = BankManagerImp()

    private let loanBusinessQueueO = OperationQueue()
    private let depositBusinessQueueO = OperationQueue()
    

    init(delegate: Workable) {
        self.delegate = delegate
        bankManager.delegate = delegate
        loanBusinessQueueO.maxConcurrentOperationCount = 1
        depositBusinessQueueO.maxConcurrentOperationCount = 2
    }
    
    // MARK: - Methods
    func handleCustomer() {
        putCustomerToSuitableQueue()
    }
    
    func resetCustomer() {
        queue.reset()
        loanBusinessQueueO.cancelAllOperations()
        depositBusinessQueueO.cancelAllOperations()
    }
    
    func addTenCustomer() {
        queue.addTenCustomer()
    }
    
    func bindUI(_ completion: @escaping ([Customer?]) -> Void) {
        queue.didChangedList = { (list) in
            completion(list)
        }
    }
    
    private func putCustomerToSuitableQueue() {
        let completionOperation = BlockOperation { [self] in
            if loanBusinessQueueO.operationCount == 0 &&
                depositBusinessQueueO.operationCount == 0 {
                delegate.allWorkisFinished()
            }
        }
        var loanWorks = [Operation]()
        var depositWorks = [Operation]()
        while let customer = queue.dequeue() {
            switch customer.business {
            case .loan:
                let loanWorkItem = BlockOperation { [self] in
                    bankManager.handle(customer: customer)
                }
                completionOperation.addDependency(loanWorkItem)
                loanWorks.append(loanWorkItem)
            case .deposit:
                let depositWorkItem = BlockOperation { [self] in
                    bankManager.handle(customer: customer)
                }
                completionOperation.addDependency(depositWorkItem)
                depositWorks.append(depositWorkItem)
            }
        }
        loanBusinessQueueO.addOperations(loanWorks, waitUntilFinished: false)
        depositBusinessQueueO.addOperations(depositWorks, waitUntilFinished: false)
        OperationQueue.main.addOperation(completionOperation)
    }
}
