//
//  UIColorExtension.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/15.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init?(hex: String?) {
        let r, g, b: CGFloat
        
        guard let hex = hex else {return nil}
        
        guard hex.hasPrefix("#") else {return nil}
        
        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])
        
        guard hexColor.count == 6 else {return nil}
        
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        
        guard scanner.scanHexInt64(&hexNumber) else {return nil}
        
        r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
        g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
        b = CGFloat((hexNumber & 0x0000ff)) / 255
        
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}

