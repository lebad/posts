//
//  PostCell.swift
//  Posts
//
//  Created by Andrey Lebedev on 07/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
	
	lazy var titleLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.font = UIFont.boldSystemFont(ofSize: 17)
		label.textColor = UIColor.black
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.backgroundColor = UIColor.white
		setupTitleLabel()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupTitleLabel() {
		self.contentView.addSubview(titleLabel)
		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			titleLabel.topAnchor.constraint(equalTo:contentView.topAnchor, constant: 16),
			titleLabel.bottomAnchor.constraint(equalTo:contentView.bottomAnchor, constant: -16)
		])
	}
}

extension PostCell: TableCellItemConstructable {
	
	func set(_ item: TableItemShowable) {
		guard let postItem = item as? PostViewModel else {
			fatalError()
		}
		titleLabel.text = postItem.title
	}
}
