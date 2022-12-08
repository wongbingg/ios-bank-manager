//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit

final class ViewController: UIViewController {
    // MARK: - Properties
    private let mainView = MainView()
    private var bank: Bank?
    private var timer: Timer?
    private var counter = 0.0
    private lazy var formatter: DateFormatter = {
        let format = DateFormatter()
        format.dateFormat = "mm:ss:SSS"
        return format
    }()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bank = BankImp(delegate: self)
        setupInitialView()
        setupButton()
        bind()
        startTimer()
        timer?.invalidate()
    }
    
    // MARK: - Methods
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
    
    private func startTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 0.001,
            target: self,
            selector: #selector(fire),
            userInfo: nil,
            repeats: true
        )
    }
    
    private func bind() {
        bank?.bindUI { [weak self](list) in
            guard list.count > 0 else {
                self?.mainView.removeAllSubviews()
                return
            }
            list.forEach { customer in
                guard let customer = customer else { return }
                let workItem = customer.generateLabel()
                self?.mainView.addProcess(with: workItem, in: .waiting)
            }
            self?.bank?.handleCustomer() // 실행 시점이 여기가 맞는지
        }
    }
    
    // MARK: - @objc Methods
    @objc private func fire() {
        self.counter += 0.001
        let currentTime = self.formatter.string(
            from: Date(timeIntervalSince1970: self.counter)
        )
        self.mainView.processTimeLabel.text = "업무시간 - " + "\(currentTime)"
    }
    
    @objc private func addTenCustomerButtonDidTapped(_ sender: UIButton) {
        bank?.addTenCustomer()
        RunLoop.main.add(timer ?? Timer(), forMode: .common)
        if timer?.isValid == false {
            startTimer()
        }
    }
    
    @objc private func resetButtonDidTapped(_ sender: UIButton) {
        bank?.resetCustomer()
        counter = 0.0
        self.mainView.processTimeLabel.text = "업무시간 - 00:00:000"
        timer?.invalidate()
        
    }
}

// MARK: - Workable
extension ViewController: Workable {
    
    func allWorkFinished() {
        timer?.invalidate()
    }
    
    func startProcess(about customer: Customer) {
        let customerOnProcessing = customer.generateLabel()
        DispatchQueue.main.async { [weak self] in
            self?.mainView.moveCell(
                name: customerOnProcessing,
                on: .waiting
            )
        }
    }
    
    func endProcess(about customer: Customer) {
        let customerOnProcessing = customer.generateLabel()
        DispatchQueue.main.async { [weak self] in
            self?.mainView.moveCell(
                name: customerOnProcessing,
                on: .processing
            )
        }
    }
}
