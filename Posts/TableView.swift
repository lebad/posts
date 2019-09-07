//
//  TableView.swift
//  Posts
//
//  Created by Andrey Lebedev on 05/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import UIKit

class TableView: UIView {
	
	var didTapItem: ((TableItemShowable, IndexPath) -> Void)?
	
	var items: [TableItemShowable] = [TableItemShowable]() {
		didSet {
			for item in items {
				let cellClass = item.cellClass
				let cellIdentifier = String(describing: cellClass)
				tableView.register(cellClass, forCellReuseIdentifier: cellIdentifier)
			}
			tableView.reloadData()
		}
	}
	
	lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.tableFooterView = UIView(frame: .zero)
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 40
		tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
		tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = UIColor.white
		setupTableView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupTableView() {
		self.addSubview(self.tableView)
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			tableView.topAnchor.constraint(equalTo: self.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}
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

extension TableView: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let item = items[indexPath.row]
		didTapItem?(item, indexPath)
		
		if let index = self.tableView.indexPathForSelectedRow {
			self.tableView.deselectRow(at: index, animated: true)
		}
	}
}
