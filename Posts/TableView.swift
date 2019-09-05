//
//  TableView.swift
//  Posts
//
//  Created by Andrey Lebedev on 05/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import UIKit

class TableView: UIView {
	
	var items: [TableItemShowable] = [TableItemShowable]() {
		didSet {
			items.forEach {
				let cellClass = $0.cellClass
				let cellIdentifier = String(describing: cellClass)
				tableView.register(cellClass, forCellReuseIdentifier: cellIdentifier)
			}
			tableView.reloadData()
		}
	}
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.dataSource = self
		tableView.tableFooterView = UIView(frame: .zero)
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 40
		tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
		tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
}

extension TableView {
	
}

extension TableView: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = items[indexPath.row]
		let cellClass = item.cellClass
		let cellIdentifier = String(describing: cellClass)
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UITableViewCell & TableCellItemConstructable
		cell.set(item)
		return cell
	}
}
