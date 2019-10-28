//
//  Post.swift
//  Posts
//
//  Created by Andrey Lebedev on 07/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

struct Post {
	var id: Int
	var userID: Int
	var title: String
	var body: String
}

extension Post: Equatable {
	
	static func == (lhs: Post, rhs: Post) -> Bool {
		return lhs.id == rhs.id && lhs.userID == rhs.userID && lhs.title == rhs.title && lhs.body == rhs.body
	}
}
