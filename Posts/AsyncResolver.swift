//
//  AsyncResolver.swift
//  Posts
//
//  Created by Andrey Lebedev on 07/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

class AsyncResolver: PostsInteractorInput {
	
	var interactor: PostsInteractorInput!
	weak var output: PostsInteractorOutput!
	
	func executePosts() {
		DispatchQueue.global(qos: .background).async {
			self.interactor.executePosts()
		}
	}
	
	func executePostInfo(post: Post) {
		DispatchQueue.global(qos: .background).async {
			self.interactor.executePostInfo(post: post)
		}
	}
}

extension AsyncResolver: PostsInteractorOutput {
	
	func didReceive(_ posts: [Post]) {
		DispatchQueue.main.async {
			self.output.didReceive(posts)
		}
	}
	
	func didReceive(errorMessage: String) {
		DispatchQueue.main.async {
			self.output.didReceive(errorMessage:errorMessage)
		}
	}
	
	func didReceive(warningMessage: String) {
		DispatchQueue.main.async {
			self.output.didReceive(warningMessage: warningMessage)
		}
	}
	
	func didReceive(_ user: User) {
		DispatchQueue.main.async {
			self.output.didReceive(user)
		}
	}
	
	func didReceive(_ comments: [Comment]) {
		DispatchQueue.main.async {
			self.output.didReceive(comments)
		}
	}
}
