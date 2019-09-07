//
//  PostsViewController.swift
//  Posts
//
//  Created by Andrey Lebedev on 05/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
	
	var output: PostsPresenter!
	
	private lazy var tableView: TableView = {
		let tableView = TableView(frame: .zero)
		tableView.didTapItem = { [unowned self] event, indexPath in
			self.output.didChoose(postAtIndex: indexPath.row)
		}
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
	
	private lazy var warningLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.font = UIFont.boldSystemFont(ofSize: 17)
		label.textAlignment = NSTextAlignment.center
		label.textColor = UIColor.darkGray
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.white
		setupWarningLabel()
		setupTableView()
		
		output.configure()
	}
	
	private func setupTableView() {
		view.addSubview(tableView)
		tableView.isHidden = true
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	private func setupWarningLabel() {
		view.addSubview(warningLabel)
		warningLabel.isHidden = true
		NSLayoutConstraint.activate([
			warningLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			warningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
			warningLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
			warningLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150)
		])
	}
}

extension PostsViewController: PostsViewInput {
	
	func show(posts: [PostViewModel]) {
		tableView.isHidden = false
		tableView.items = posts
	}
	
	func show(screenTitle: String) {
		navigationItem.title = screenTitle
	}
	
	func show(errorMessage: String) {
		show(alertText:errorMessage)
	}
	
	func show(warningMessage: String) {
		warningLabel.isHidden = false
		warningLabel.text = warningMessage
	}
}

extension PostsViewController: LoaderShowable {
	
	func startLoading() {
		
	}
	
	func finishLoading() {
		
	}
}

extension PostViewModel: TableItemShowable {
	var cellClass: UITableViewCell.Type {
		get {
			return PostCell.self
		}
	}
}
