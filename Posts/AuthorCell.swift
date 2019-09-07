//
//  AuthorCell.swift
//  Posts
//
//  Created by Andrey Lebedev on 15/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import UIKit

class AuthorCell: UITableViewCell {
	
	lazy var nameLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.font = UIFont.boldSystemFont(ofSize: 11)
		label.textColor = UIColor.black
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	
	lazy var emailLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.font = UIFont.boldSystemFont(ofSize: 11)
		label.textColor = UIColor.gray
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.backgroundColor = UIColor.white
		setupNameLabel()
		setupEmailLabel()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupNameLabel() {
		contentView.addSubview(nameLabel)
		NSLayoutConstraint.activate([
			nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			nameLabel.topAnchor.constraint(equalTo:contentView.topAnchor, constant: 16),
		])
	}
	
	private func setupEmailLabel() {
		contentView.addSubview(emailLabel)
		NSLayoutConstraint.activate([
			emailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			emailLabel.topAnchor.constraint(equalTo:nameLabel.topAnchor, constant: 16),
			emailLabel.bottomAnchor.constraint(equalTo:contentView.bottomAnchor, constant: -16)
		])
	}
}

extension AuthorCell: TableCellItemConstructable {
	
	func set(_ item: TableItemShowable) {
		guard let authorItem = item as? AuthorViewModel else {
			fatalError()
		}
		nameLabel.text = authorItem.username
		emailLabel.text = authorItem.email
	}
}
