//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    var mainView: MainView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView = MainView(self)
        mainView?.addTenCustomerButton.addTarget(self, action: #selector(addTenCustomerButtonDidTapped), for: .touchUpInside)
        mainView?.resetButton.addTarget(self, action: #selector(resetButtonDidTapped), for: .touchUpInside)
    }
    
    @objc func addTenCustomerButtonDidTapped(_ sender: UIButton) {
        print("10명의 고객 추가")
    }
    
    @objc func resetButtonDidTapped(_ sender: UIButton) {
        print("리셋버튼 ")
    }
}

