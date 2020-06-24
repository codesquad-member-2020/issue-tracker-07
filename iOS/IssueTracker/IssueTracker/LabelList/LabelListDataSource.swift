//
//  LabelListDataSource.swift
//  IssueTracker
//
//  Created by TTOzzi on 2020/06/24.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class LabelListDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LabelCell.identifier, for: indexPath) as? LabelCell else { return UITableViewCell() }
        return cell
    }
}

