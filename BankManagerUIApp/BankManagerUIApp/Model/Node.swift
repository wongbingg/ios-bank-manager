//
//  Node.swift
//  BankManagerUIApp
//
//  Created by 이원빈 on 2022/07/07.
//

final class Node<T> {
    private(set) var data: T
    var next: Node<T>?
    
    init(_ data: T) {
        self.data = data
        self.next = nil
    }
}
