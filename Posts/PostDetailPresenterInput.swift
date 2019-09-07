//
//  PostDetailPresenterInput.swift
//  Posts
//
//  Created by Andrey Lebedev on 15/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

protocol PostDetailPresenterInput: AnyObject {
	func present(post: Post)
	func present(user: User)
	func present(comments: [Comment])
}
