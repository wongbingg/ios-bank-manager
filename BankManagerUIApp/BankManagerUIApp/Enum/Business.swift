//
//  Business.swift
//  BankManagerUIApp
//
//  Created by 이원빈 on 2022/07/07.
//

import Foundation

enum Business: String {
    case deposit = "예금"
    case loan = "대출"
    
    var name: String {
        rawValue
    }
    
    var processTime: TimeInterval {
        switch self {
        case .deposit:
            return 0.7
        case .loan:
            return 1.1
        }
    }
}
