//
//  UserService.swift
//  Posts
//
//  Created by Andrey Lebedev on 15/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

protocol UserService: AnyObject {
	func getUserFor(id: Int) throws -> User?
}
