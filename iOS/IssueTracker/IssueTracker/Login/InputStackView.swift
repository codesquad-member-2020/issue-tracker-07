//
//  InputStackView.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/09.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

final class InputStackView: UIStackView {
    
    // MARK: - Properties
    private var titleLabel: UILabel!
    private var inputTextField: UITextField!
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    // MARK: - Methods
    // MARK: Accessible
    func update(with title: String?) {
        titleLabel.text = title
    }
    
    // MARK: SetUp
    private func setUp() {
        axis = .vertical
        spacing = 5
        distribution = .fill
        setUpTitleLabel()
        setUpInputTextField()
    }
    
    private func setUpTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 12)
        addArrangedSubview(titleLabel)
    }
    
    private func setUpInputTextField() {
        inputTextField = UITextField()
        inputTextField.borderStyle = .roundedRect
        addArrangedSubview(inputTextField)
    }
}
