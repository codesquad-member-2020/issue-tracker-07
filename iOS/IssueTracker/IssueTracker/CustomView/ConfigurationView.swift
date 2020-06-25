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
    
    private(set) var closeButton: UIButton!
    
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
    }
    
    private func setUpCloseButton() {
        closeButton = BorderButton()
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .black
        addSubview(closeButton)

    }
    
    private func makeContraints() {
        makeContraintsCloseButton()
    }
    
    private func makeContraintsCloseButton() {
        closeButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
    }
}
