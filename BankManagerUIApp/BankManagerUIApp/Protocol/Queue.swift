//
//  Queue.swift
//  BankManagerUIApp
//
//  Created by 이원빈 on 2022/07/07.
//

protocol Queue {
    associatedtype Element
    
    var queue: LinkedList<Element> { get }
    var isEmpty: Bool { get }
    var peek: Element? { get }
    var count: Int { get }
    var currentList: [Element?] { get }
    
    func enqueue(data: Element)
    func dequeue() -> Element?
    func clear()
}
