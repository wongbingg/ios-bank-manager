//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {
    var bank: Bank?
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
        configureBankType()
        mainView = MainView(self)
        mainView?.addTenCustomerButton.addTarget(self, action: #selector(addTenCustomerButtonDidTapped), for: .touchUpInside)
        mainView?.resetButton.addTarget(self, action: #selector(resetButtonDidTapped), for: .touchUpInside)
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
    }
    
    func configureBankType() {
        var manager = BankManager()
        let queue = CustomerQueue()
        bank = Bank(employee: manager, customer: queue)
        manager.delegate = self
        bank?.delegate = self
    }
    
    @objc func addTenCustomerButtonDidTapped(_ sender: UIButton) {
        let prevQueue = bank?.queue.currentList
        bank?.updateCustomerQueue()
        let currentQueue = bank?.queue.currentList.filter { prevQueue?.contains($0) == false}
        currentQueue?.forEach { customer in
            guard let number = customer?.number, let business = customer?.business else { return }
            mainView?.addProcess(text: "\(number) - \(business.name)" )
        }
        bank?.handleCustomer()
        
        if timer?.isValid == false {
            timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(fire), userInfo: nil, repeats: true)
        }
    }
    
    @objc func resetButtonDidTapped(_ sender: UIButton) {
        mainView?.waitingStackView.subviews.forEach {
            mainView?.waitingStackView.removeArrangedSubview($0)
            $0.isHidden = true
        }
        timer?.invalidate()
        self.mainView?.processTimeLabel.text = "업무시간 - 00:00:000"
    }
    
    @objc func fire() {
        self.counter += 0.001
        let currentTime = self.mFormatter.string(from: Date(timeIntervalSince1970: self.counter))
        self.mainView?.processTimeLabel.text = "업무시간 - \(currentTime)"
    }
}

extension ViewController: Showable {
    func allWorkisFinished() {
        timer?.invalidate()
        print("타이머 정지로직이 실행되었다")
    }
    
    func startProcess(about customer: Customer) { // 대기중 열에있는 업무를 업무중으로 옮기는 UI Update 구현
        let number = customer.number
        let business = customer.business
        DispatchQueue.main.async { [self] in
            mainView?.waitingStackView.arrangedSubviews.forEach { // label 에 접근해야한다. 그 label이 제시된 string과 같다면 제거해주는 로직
                let label = $0 as? UILabel
                if label?.text == "\(number) - \(business.name)" {
                    mainView?.waitingStackView.removeArrangedSubview($0) // UI 변경
                    $0.isHidden = true
                }
            }
            mainView?.startProcessing(text: "\(number) - \(business.name)")
        }
    }
    
    func endProcess(about customer: Customer) { // 업무중 열에있는 업무를 삭제하는 UI Update 구현
        let number = customer.number
        let business = customer.business
        DispatchQueue.main.async { [self] in
            mainView?.processingStackView.arrangedSubviews.forEach {
                let label = $0 as? UILabel
                if label?.text == "\(number) - \(business.name)" {
                    mainView?.processingStackView.removeArrangedSubview($0)
                    $0.isHidden = true
                }
            }
        }
    }
}
