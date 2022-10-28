//
//  MainView.swift
//  BankManagerUIApp
//
//  Created by 예톤, 웡빙 on 2022/07/10.
//

import UIKit

final class MainView: UIView {
    private let mainStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    // MARK: - Buttons
    private let twoButtonStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.distribution = .fillEqually
        return stackview
    }()
    
    let addTenCustomerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("고객 10명 추가", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        return button
    }()
    
    // MARK: - Process Time
    let processTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.text = "업무시간 - 00:00:000"
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - 대기중/ 업무중
    private let currentStateStackView: UIStackView = {
       let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.distribution = .fillEqually
        return stackview
    }()
    
    private let waitingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.text = "대기중"
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .systemGreen
        return label
    }()
    
    private let processingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.text = "업무중"
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor(red: 50.0/255, green: 58.0/255, blue: 200.0/255, alpha: 1.0)
        return label
    }()
    
    // MARK: - 대기중 scrollView
    private let waitingScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let waitingStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        return stackview
    }()
    
    // MARK: - 업무중 scrollView
    private let processingScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let processingStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        return stackview
    }()
    
    // MARK: - Initializers
    init() {
        super.init(frame: .null)
        addAllSubViews()
        setupMainStackConstraints()
        setupScrollViewConstraints()
        setupScrollViewInsideConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func addAllSubViews() {
        addSubview(mainStackView)
        addSubview(waitingScrollView)
        addSubview(processingScrollView)
        
        twoButtonStackView.addArrangedSubview(addTenCustomerButton)
        twoButtonStackView.addArrangedSubview(resetButton)
        currentStateStackView.addArrangedSubview(waitingLabel)
        currentStateStackView.addArrangedSubview(processingLabel)
        
        mainStackView.addArrangedSubview(twoButtonStackView)
        mainStackView.addArrangedSubview(processTimeLabel)
        mainStackView.addArrangedSubview(currentStateStackView)
        
        waitingScrollView.addSubview(waitingStackView)
        processingScrollView.addSubview(processingStackView)
    }
    
    private func setupMainStackConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.17 )
        ])
    }
    
    private func setupScrollViewConstraints() {
        NSLayoutConstraint.activate([
            waitingScrollView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            waitingScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            waitingScrollView.trailingAnchor.constraint(equalTo: centerXAnchor),
            waitingScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            processingScrollView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            processingScrollView.leadingAnchor.constraint(equalTo: centerXAnchor),
            processingScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            processingScrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupScrollViewInsideConstraints() {
        NSLayoutConstraint.activate([
            waitingStackView.topAnchor.constraint(equalTo: waitingScrollView.contentLayoutGuide.topAnchor),
            waitingStackView.bottomAnchor.constraint(equalTo: waitingScrollView.contentLayoutGuide.bottomAnchor),
            waitingStackView.leadingAnchor.constraint(equalTo: waitingScrollView.contentLayoutGuide.leadingAnchor),
            waitingStackView.trailingAnchor.constraint(equalTo: waitingScrollView.contentLayoutGuide.trailingAnchor),
            waitingStackView.widthAnchor.constraint(equalTo: waitingScrollView.widthAnchor),
            
            processingStackView.topAnchor.constraint(equalTo: processingScrollView.contentLayoutGuide.topAnchor),
            processingStackView.bottomAnchor.constraint(equalTo: processingScrollView.contentLayoutGuide.bottomAnchor),
            processingStackView.leadingAnchor.constraint(equalTo: processingScrollView.contentLayoutGuide.leadingAnchor),
            processingStackView.trailingAnchor.constraint(equalTo: processingScrollView.contentLayoutGuide.trailingAnchor),
            processingStackView.widthAnchor.constraint(equalTo: processingScrollView.widthAnchor),
        ])
    }
    
    func addProcess(with text: String, in state: State) {
        let processLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.preferredFont(forTextStyle: .title2)
            if text.hasSuffix("대출") {
                label.textColor = .systemPurple
            }
            label.text = text
            label.textAlignment = .center
            return label
        }()
        if state == .processing {
            processingStackView.addArrangedSubview(processLabel)
        } else {
            waitingStackView.addArrangedSubview(processLabel)
        }
    }
}

enum State {
    case processing
    case waiting
}
