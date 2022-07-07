//
//  Showable.swift
//  BankManagerUIApp
//
//  Created by 이원빈 on 2022/07/07.
//

import Foundation

protocol Showable {
    func startProcess(about customer: Customer)
    func endProcess(about customer: Customer)
    func allWorkisFinished()
}
