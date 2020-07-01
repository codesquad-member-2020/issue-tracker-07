//
//  ConfigurationView.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/25.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit
import SnapKit

class ConfigurationView: UIView {
    
    private(set) var closeButton: BorderButton!
    private var divisionLineView: UIView!
    private(set) var resetButton: BorderButton!
    private(set) var saveButton: BorderButton!
    private(set) var containerStackView: UIStackView!
    private(set) var firstFunctionView: FunctionView!
    private(set) var secondFunctionView: FunctionView!
    private(set) var thirdFunctionView: FunctionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        makeContraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
        makeContraints()
    }
    
    private func setUp() {
        layer.cornerRadius = 5
        setUpCloseButton()
        setUpDivisionLineView()
        setUpResetButton()
        setUpSaveButton()
        setUpContainerStackView()
        setUpFirstFunctionView()
        setUpSecondFunctionView()
        setUpThirdFunctionView()
    }
    
    private func setUpCloseButton() {
        closeButton = BorderButton()
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .label
        closeButton.setContentHuggingPriority(.defaultHigh, for: .vertical)
        addSubview(closeButton)
    }
    
    private func setUpDivisionLineView() {
        divisionLineView = UIView()
        divisionLineView.backgroundColor = .separator
        addSubview(divisionLineView)
    }
    
    private func setUpResetButton() {
        resetButton = BorderButton()
        resetButton.setTitle("초기화", for: .normal)
        resetButton.titleLabel?.font = .systemFont(ofSize: 14)
        resetButton.setTitleColor(.systemGray, for: .normal)
        addSubview(resetButton)
    }
    
    private func setUpSaveButton() {
        saveButton = BorderButton()
        saveButton.setTitle("저장", for: .normal)
        saveButton.setTitleColor(.systemBackground, for: .normal)
        saveButton.backgroundColor = .label
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        saveButton.cornerRadius = 5
        addSubview(saveButton)
    }
    
    private func setUpContainerStackView() {
        containerStackView = UIStackView()
        containerStackView.distribution = .fillEqually
        containerStackView.axis = .vertical
        addSubview(containerStackView)
    }
    
    private func setUpFirstFunctionView() {
        firstFunctionView = FunctionView()
        containerStackView.addArrangedSubview(firstFunctionView)
    }
    
    private func setUpSecondFunctionView() {
        secondFunctionView = FunctionView()
        containerStackView.addArrangedSubview(secondFunctionView)
    }
    
    private func setUpThirdFunctionView() {
        thirdFunctionView = FunctionView()
        containerStackView.addArrangedSubview(thirdFunctionView)
    }
    
    private func makeContraints() {
        makeContraintsCloseButton()
        makeContraintsDivisionLineView()
        makeConstraintsResetButton()
        makeConstraintsSaveButton()
        makeConstraintsContainerStackView()
    }
    
    private func makeContraintsCloseButton() {
        closeButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(15)
        }
    }
    
    private func makeContraintsDivisionLineView() {
        divisionLineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(closeButton.snp.bottom).offset(15)
        }
    }
    
    private func makeConstraintsResetButton() {
        resetButton.snp.makeConstraints {
            $0.leading.equalTo(closeButton.snp.leading)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func makeConstraintsSaveButton() {
        saveButton.snp.makeConstraints {
            $0.width.equalToSuperview().dividedBy(5)
            $0.height.equalToSuperview().dividedBy(8)
            $0.trailing.equalToSuperview().inset(15)
            $0.bottom.equalTo(resetButton.snp.bottom)
        }
    }
    
    private func makeConstraintsContainerStackView() {
        containerStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(divisionLineView.snp.bottom).offset(20)
            $0.bottom.equalTo(saveButton.snp.top).offset(-20)
        }
    }
}
