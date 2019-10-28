//
//  CommentCell.swift
//  Posts
//
//  Created by Andrey Lebedev on 15/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
	
	lazy var nameLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.font = UIFont.boldSystemFont(ofSize: 11)
		label.textColor = UIColor.black
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	
	lazy var descriptionLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.font = UIFont.boldSystemFont(ofSize: 10)
		label.textColor = UIColor.darkGray
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.backgroundColor = UIColor.white
		setupNameLabel()
		setupDescriptionLabel()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupNameLabel() {
		contentView.addSubview(nameLabel)
		NSLayoutConstraint.activate([
			nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			nameLabel.topAnchor.constraint(equalTo:contentView.topAnchor, constant: 16)
		])
	}
	
	private func setupDescriptionLabel() {
		contentView.addSubview(descriptionLabel)
		NSLayoutConstraint.activate([
			descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
			descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
		])
	}
}

extension CommentCell: TableCellItemConstructable {
	
	func set(_ item: TableItemShowable) {
		guard let commentItem = item as? CommentViewModel else {
			fatalError()
		}
		nameLabel.text = commentItem.name
		descriptionLabel.text = commentItem.text
	}
}
