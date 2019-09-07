//
//  PostDetailViewInput.swift
//  Posts
//
//  Created by Andrey Lebedev on 12/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

protocol PostDetailViewInput: AnyObject {
	func add(post: PostDetailViewModel)
	func add(author: AuthorViewModel)
	func add(commentsTitle: CommentsTitleViewModel)
	func updateInfoContent()
	func show(comments: [CommentViewModel])
	func show(screenTitle: String)
	func show(errorMessage: String)
}
