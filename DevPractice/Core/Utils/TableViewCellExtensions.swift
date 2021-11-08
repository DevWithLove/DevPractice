//
//  TableViewCell.swift
//  DevPractice
//
//  Created by Tony Mu on 8/11/21.
//

import UIKit

extension UITableView {
    func regisger<T: UITableViewCell>(cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.cellId)
    }
}

extension UITableViewCell {
    static var cellId: String {
        return String(describing: self).lowercased()
    }
}
