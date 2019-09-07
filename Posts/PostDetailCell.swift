//
//  PostDetailCell.swift
//  Posts
//
//  Created by Andrey Lebedev on 15/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import UIKit

class PostDetailCell: UITableViewCell {
	
	lazy var titleLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.font = UIFont.boldSystemFont(ofSize: 17)
		label.textColor = UIColor.black
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var bodyLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.font = UIFont.boldSystemFont(ofSize: 11)
		label.textColor = UIColor.black
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.backgroundColor = UIColor.white
		setupTitleLabel()
		setupBodyLable()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupTitleLabel() {
		contentView.addSubview(titleLabel)
		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			titleLabel.topAnchor.constraint(equalTo:contentView.topAnchor, constant: 16),
		])
	}
	
	private func setupBodyLable() {
		contentView.addSubview(bodyLabel)
		NSLayoutConstraint.activate([
			bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			bodyLabel.topAnchor.constraint(equalTo:titleLabel.bottomAnchor, constant: 16),
			bodyLabel.bottomAnchor.constraint(equalTo:contentView.bottomAnchor, constant: -16)
		])
	}
}

extension PostDetailCell: TableCellItemConstructable {
	
	func set(_ item: TableItemShowable) {
		guard let postItem = item as? PostDetailViewModel else {
			fatalError()
		}
		titleLabel.text = postItem.title
		bodyLabel.text = postItem.text
	}
}
