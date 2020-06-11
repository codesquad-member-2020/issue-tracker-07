//
//  UIViewControllerExtension.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/11.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(title: String?, message: String?, actions: [String : ((UIAlertAction) -> ())?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { key, value in
            alert.addAction(UIAlertAction(title: key, style: .default, handler: value))
        }
        
        present(alert, animated: true)
    }
}
