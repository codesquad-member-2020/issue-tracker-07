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
    private(set) var resetButton: BorderButton!
    private(set) var saveButton: BorderButton!
    
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
    }
    
    private func setUpCloseButton() {
        closeButton = BorderButton()
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .black
        addSubview(closeButton)
    }
    
    private func setUpDivisionLineView() {
        let divisionLineView = UIView()
        divisionLineView.backgroundColor = .systemGray
        addSubview(divisionLineView)
        divisionLineView.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.width.equalToSuperview()
            $0.top.equalTo(closeButton.snp.bottom).offset(15)
        }
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
    
    private func makeContraints() {
        makeContraintsCloseButton()
        makeConstraintsResetButton()
        makeConstraintsSaveButton()
    }
    
    private func makeContraintsCloseButton() {
        closeButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(15)
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
}
