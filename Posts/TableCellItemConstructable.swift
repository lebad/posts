//
//  TableCellItemConstructable.swift
//  Posts
//
//  Created by Andrey Lebedev on 05/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

protocol TableCellItemConstructable: AnyObject {
	
	func set(_ item: TableItemShowable)
}
