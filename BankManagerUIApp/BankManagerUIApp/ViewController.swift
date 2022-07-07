//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    var mainView: MainView?
    var counter = 0.0
    var timer: Timer?
    lazy var mFormatter: DateFormatter = {
       
        let format = DateFormatter()
        format.dateFormat = "mm:ss:SSS"
        return format
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        mainView = MainView(self)
        mainView?.addTenCustomerButton.addTarget(self, action: #selector(addTenCustomerButtonDidTapped), for: .touchUpInside)
        mainView?.resetButton.addTarget(self, action: #selector(resetButtonDidTapped), for: .touchUpInside)
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
    }
    
    @objc func addTenCustomerButtonDidTapped(_ sender: UIButton) {
        for _ in 1...10 {
            mainView?.addProcess(text: "고객")
        }
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
    }
    
    @objc func resetButtonDidTapped(_ sender: UIButton) {
        mainView?.waitingStackView.subviews.forEach {
            mainView?.waitingStackView.removeArrangedSubview($0)
            $0.isHidden = true
        }
        timer?.invalidate()
    }
    
    @objc func fire() {
        self.counter += 0.001
        let currentTime = self.mFormatter.string(from: Date(timeIntervalSince1970: self.counter))
        self.mainView?.processTimeLabel.text = "업무시간 - \(currentTime)"
    }

}

