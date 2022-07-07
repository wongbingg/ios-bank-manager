//
//  CustomerQueue.swift
//  BankManagerUIApp
//
//  Created by 이원빈 on 2022/07/07.
//

struct CustomerQueue: Queue {
    private(set) var queue: LinkedList<Customer>
    
    init(elements: [Customer] = []) {
        queue = LinkedList()
        elements.forEach {
            self.enqueue(data: $0)
        }
    }
}
