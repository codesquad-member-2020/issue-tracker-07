//
//  InputStackView.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/09.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

@IBDesignable
final class InputStackView: UIStackView {
    
    // MARK: - IBInspectables
    @IBInspectable var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    @IBInspectable var isSecureTextEntry: Bool {
        get { inputTextField.isSecureTextEntry }
        set { inputTextField.isSecureTextEntry = newValue }
    }
    
    // MARK: - Properties
    private var titleLabel: UILabel!
    private var inputTextField: UITextField!
    private var handler: (String?) -> () = {_ in}
    
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
    
    func bind(_ handler: @escaping (String?) -> ()) {
        self.handler = handler
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
        inputTextField.addTarget(self, action: #selector(inputEditing(_:)), for: .editingChanged)
        addArrangedSubview(inputTextField)
        inputTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    // MARK: Objc
    @objc private func inputEditing(_ sender: UITextField) {
        handler(sender.text)
    }
}
