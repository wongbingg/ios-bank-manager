//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

final class ViewController: UIViewController {
    private let mainView = MainView()
    private var bank: Bank?
    private var timer: Timer?
    private var counter = 0.0
    lazy var formatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "mm:ss:SSS"
        return format
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupButton()
        makeBankInstance()
        startTimer()
        timer?.invalidate()
    }
    
    private func setupInitialView() {
        view.backgroundColor = .systemBackground
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func setupButton() {
        mainView.addTenCustomerButton.addTarget(
            self,
            action: #selector(addTenCustomerButtonDidTapped(_:)),
            for: .touchUpInside
        )
        mainView.resetButton.addTarget(
            self,
            action: #selector(resetButtonDidTapped(_:)),
            for: .touchUpInside
        )
    }
    
    private func makeBankInstance() {
        bank = Bank(employee: makeManagerInstance(),
                    customer: CustomerQueue())
        bank?.delegate = self
    }
    
    private func makeManagerInstance() -> BankManager {
        var manager = BankManagerImp()
        manager.delegate = self
        return manager
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 0.001,
            target: self,
            selector: #selector(fire),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc private func fire() {
        self.counter += 0.001
        let currentTime = self.formatter.string(
            from: Date(timeIntervalSince1970: self.counter)
        )
        self.mainView.processTimeLabel.text = "업무시간 - \(currentTime)"
    }
    
    @objc private func addTenCustomerButtonDidTapped(_ sender: UIButton) {
        RunLoop.main.add(timer ?? Timer(), forMode: .common)
        bank?.updateCustomerQueue()
        bank?.queue.currentList.forEach { customer in
            guard let number = customer?.number,
                  let business = customer?.business else {
                return
            }
            
            let workItem = "\(number) - \(business.name)"
            mainView.addProcessInWaitingStackView(text: workItem)
        }
        bank?.handleCustomer()
        
        if timer?.isValid == false {
            startTimer()
        }
    }
    
    @objc private func resetButtonDidTapped(_ sender: UIButton) {
        removeAllSubviews(in: mainView.waitingStackView)
        removeAllSubviews(in: mainView.processingStackView)
        counter = 0.0
        self.mainView.processTimeLabel.text = "업무시간 - 00:00:000"
        timer?.invalidate()
    }
    
    private func removeAllSubviews(in view: UIStackView?) {
        view?.subviews.forEach {
            view?.removeSubview($0)
        }
    }
}

extension ViewController: Workable {
    
    func allWorkisFinished() {
        timer?.invalidate()
    }
    
    func startProcess(about customer: Customer) {
        let customerOnProcessing = "\(customer.number) - \(customer.business.name)"
        
        DispatchQueue.main.async { [weak self] in
            let labelList = self?.mainView.waitingStackView.arrangedSubviews.compactMap {
                $0 as? UILabel
            }.filter {
                $0.text == customerOnProcessing
            }
            guard let label = labelList?.first else {
                return
            }
            self?.mainView.waitingStackView.removeSubview(label)
            self?.mainView.addProcessInProcessingStackView(text: customerOnProcessing)
        }
    }
    
    func endProcess(about customer: Customer) {
        let customerOnProcessing = "\(customer.number) - \(customer.business.name)"
        
        DispatchQueue.main.async { [weak self] in
            let labelList = self?.mainView.processingStackView.arrangedSubviews.compactMap {
                $0 as? UILabel
            }.filter {
                $0.text == customerOnProcessing
            }
            guard let label = labelList?.first else {
                return
            }
            self?.mainView.processingStackView.removeSubview(label)
        }
    }
}
