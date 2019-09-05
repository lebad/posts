//
//  TTableItemShowable.swift
//  Posts
//
//  Created by Andrey Lebedev on 05/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import UIKit

protocol TableItemShowable {
	var cellClass: UITableViewCell.Type { get }
	var cellIdentifier: String { get }
}

extension TableItemShowable {
	
	var cellIdentifier: String {
		get {
			let cellClass = self.cellClass
			let cellIdentifier = String(describing: cellClass)
			return cellIdentifier
		}
	}
}
