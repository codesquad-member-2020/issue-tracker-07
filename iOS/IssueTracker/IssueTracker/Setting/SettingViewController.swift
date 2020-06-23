//
//  SettingViewController.swift
//  IssueTracker
//
//  Created by 신한섭 on 2020/06/19.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        decodeToken()
    }
    
    func decodeToken() {
        guard let token = NetworkManager.token else { return }
        let payload = TokenDecoder.decode(jwtToken: token)
        nameLabel.text = payload["USER_NAME"] as? String
        emailLabel.text = payload["LOGIN_ID"] as? String
    }
    
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        NetworkManager.token = nil
    }
}
