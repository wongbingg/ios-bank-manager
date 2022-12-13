//
//  Showable.swift
//  BankManagerUIApp
//
//  Created by 예톤, 웡빙 on 2022/07/10.
//

import Foundation

protocol Workable: AnyObject {
    func startProcess(about customer: Customer)
    func endProcess(about customer: Customer)
    func allWorkFinished()
}
