//
//  PostDetailViewController.swift
//  Posts
//
//  Created by Andrey Lebedev on 12/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
	
	var output: PostDetailPresenter!
	
	private lazy var infoTableView: TableView = {
		let tableView = TableView(frame: .zero)
		tableView.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
		tableView.tableView.allowsSelection = false
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
	
	private var infoItems = [TableItemShowable]()
	private var commentItems = [TableItemShowable]()
	
	private lazy var commentsTableView: TableView = {
		let tableView = TableView(frame: .zero)
		tableView.tableView.allowsSelection = false
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.white
		setupInfoTableView()
		setupCommentsTableView()
		
		output.configure()
	}
	
	private func setupInfoTableView() {
		view.addSubview(infoTableView)
		NSLayoutConstraint.activate([
			infoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			infoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			infoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			infoTableView.heightAnchor.constraint(equalToConstant: 250)
		])
	}
	
	private func setupCommentsTableView() {
		view.addSubview(commentsTableView)
		NSLayoutConstraint.activate([
			commentsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			commentsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			commentsTableView.topAnchor.constraint(equalTo: infoTableView.bottomAnchor),
			commentsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}

extension PostDetailViewController: LoaderShowable {
	
	func startLoading() {
		
	}
	
	func finishLoading() {
		
	}
}

extension PostDetailViewController: PostDetailViewInput {
	
	func add(post: PostDetailViewModel) {
		infoItems.append(post)
	}
	
	func add(author: AuthorViewModel) {
		infoItems.append(author)
	}
	
	func updateInfoContent() {
		infoTableView.items = infoItems
	}
	
	func add(commentsTitle: CommentsTitleViewModel) {
		commentItems.append(commentsTitle)
	}
	
	func show(comments: [CommentViewModel]) {
		commentItems.append(contentsOf: comments)
		commentsTableView.items = commentItems
	}
	
	func show(screenTitle: String) {
		navigationItem.title = screenTitle
	}
	
	func show(errorMessage: String) {
		show(alertText:errorMessage)
	}
}

extension PostDetailViewModel: TableItemShowable {
	var cellClass: UITableViewCell.Type {
		get {
			return PostDetailCell.self
		}
	}
}

extension AuthorViewModel: TableItemShowable {
	var cellClass: UITableViewCell.Type {
		get {
			return AuthorCell.self
		}
	}
}

extension CommentsTitleViewModel: TableItemShowable {
	var cellClass: UITableViewCell.Type {
		get {
			return CommentsTitleCell.self
		}
	}
}

extension CommentViewModel: TableItemShowable {
	var cellClass: UITableViewCell.Type {
		get {
			return CommentCell.self
		}
	}
}
