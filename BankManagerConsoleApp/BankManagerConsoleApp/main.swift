//
//  BankManagerConsoleApp - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

var bank = Bank(bankManager: BankManager(), queue: CustomerQueue())

bank.start()
