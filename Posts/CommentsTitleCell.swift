//
//  CommentsTitleCell.swift
//  Posts
//
//  Created by Andrey Lebedev on 15/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import UIKit

class CommentsTitleCell: UITableViewCell {
	
	lazy var titleLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.font = UIFont.boldSystemFont(ofSize: 14)
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

extension CommentsTitleCell: TableCellItemConstructable {
	
	func set(_ item: TableItemShowable) {
		guard let commentsTitleItem = item as? CommentsTitleViewModel else {
			fatalError()
		}
		titleLabel.text = commentsTitleItem.title
	}
}
