//
//  Queue+Extension.swift
//  BankManagerUIApp
//
//  Created by 이원빈 on 2022/07/07.
//

extension Queue {
    var isEmpty: Bool {
        queue.isEmpty
    }
    var peek: Element? {
        queue.peek
    }
    var count: Int {
        queue.count
    }
    var currentList: [Element?] {
        queue.currentList
    }

    func enqueue(data: Element) {
        queue.append(data: data)
    }

    @discardableResult
    func dequeue() -> Element? {
        queue.removeFirst()
    }

    func clear() {
        queue.clear()
    }
}
