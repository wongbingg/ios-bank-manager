//
//  CustomerQueue.swift
//  BankManagerConsoleApp
//
//  Created by 예톤, 웡빙 on 2022/06/27.
//

final class CustomerQueue: Queue {
    private(set) var queue = LinkedList<Customer>()
    private(set) var countOfCustomer = 1
    var didChangedList: (([Customer?]) -> Void)?
    
    func addTenCustomer() {
        let newList = self.generateCustomers()
        newList.forEach { customer in
            enqueue(data: customer)
        }
        let count = currentList.count
        didChangedList?(Array(currentList[count-10...count-1]))
    }
    
    func reset() {
        self.countOfCustomer = 1
        clear()
        didChangedList?([])
    }
    
    private func generateCustomers() -> [Customer] {
        let businessList = [Business.loan, Business.deposit]
        var result = [Customer]()
        (countOfCustomer...(countOfCustomer + 9)).forEach { number in
            let randomNumber = Int.random(in: 0...1)
            let customer = Customer(number: number, business: businessList[randomNumber])
            result.append(customer)
        }
        countOfCustomer += 10
        return result
    }
}
