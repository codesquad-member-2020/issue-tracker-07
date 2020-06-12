//
//  BorderButton.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/09.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

@IBDesignable
final class BorderButton: UIButton {

    // MARK: - IBInspectables
    // MARK: Border
    @IBInspectable var borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    @IBInspectable var borderColor: UIColor {
        get { UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor) }
        set { layer.borderColor = newValue.cgColor }
    }
    // MARK: CornerRadius
    @IBInspectable var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    // MARK: - Methods
    private func setUp() {
        self.addTarget(self, action: #selector(animate(_:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(animate(_:)), for: .touchDown)
        self.addTarget(self, action: #selector(animate(_:)), for: .touchUpOutside)
        tintColor = backgroundColor
    }
    
    private func scaleUp(_ sender: UIButton) {
        UIView.animate(withDuration: 0.15, delay: 0, options: .allowUserInteraction, animations: {
            sender.transform = .identity
        })
    }
    
    private func scaleDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.15, delay: 0, options: .allowUserInteraction, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        })
    }
    
    // MARK: - Objc
    @objc private func animate(_ sender: UIButton) {
        isSelected.toggle()
        isSelected ? scaleDown(sender) : scaleUp(sender)
    }
}
