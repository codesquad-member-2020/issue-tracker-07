//
//  FunctionView.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/25.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class FunctionView: UIView {
    
    private var divisionLineView: UIView!
    private var containerStackView: UIStackView!
    private(set) var titleLabel: UILabel!
    private(set) var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    private func setUp() {
        setUpDivisionLineView()
        setUpContainerStackView()
        setUpTitleLabel()
        setUpContentView()
    }
    
    private func setUpDivisionLineView() {
        divisionLineView = UIView()
        divisionLineView.backgroundColor = .separator
        addSubview(divisionLineView)
        divisionLineView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    private func setUpContainerStackView() {
        containerStackView = UIStackView()
        containerStackView.axis = .horizontal
        addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(divisionLineView.snp.top)
        }
    }
    
    private func setUpTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "제목"
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        containerStackView.addArrangedSubview(titleLabel)
    }
    
    private func setUpContentView() {
        contentView = UIView()
        containerStackView.addArrangedSubview(contentView)
    }
}
