//
//  PostsInteractorOutputSpy.swift
//  PostsTests
//
//  Created by Andrey Lebedev on 16/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

@testable import Posts
import Foundation

class PostsInteractorOutputSpy: PostsInteractorOutput {
	
	var posts: [Post]?
	var user: User?
	var comments: [Comment]?
	var errorMessage: String?
	var warningMessage: String?
	
	func didReceive(_ posts: [Post]) {
		self.posts = posts
	}
	
	func didReceive(_ user: User) {
		self.user = user
	}
	
	func didReceive(_ comments: [Comment]) {
		self.comments = comments
	}
	
	func didReceive(errorMessage: String) {
		self.errorMessage = errorMessage
	}
	
	func didReceive(warningMessage: String) {
		self.warningMessage = warningMessage
	}
}
