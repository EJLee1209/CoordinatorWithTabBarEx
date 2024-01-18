//
//  UITableviewController+.swift
//  CoordinatorWithTabBarEx
//
//  Created by 이은재 on 1/18/24.
//

import UIKit

extension UITableViewController {
    func addSpinnerLastCell() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = .init(x: .zero, y: .zero, width: tableView.bounds.width, height: 44)
        tableView.tableFooterView = spinner
    }
}
