//
//  PostLocalServiceStub.swift
//  PostsTests
//
//  Created by Andrey Lebedev on 16/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

@testable import Posts
import Foundation

class PostServiceStub: PostService {
	
	var posts: [Post]
	
	init(posts: [Post]) {
		self.posts = posts
	}
	
	func getAllPosts() throws -> [Post] {
		return posts
	}
	
	func update(_ posts: [Post]) throws {
		
	}
}

class PostServiceErrorStub: PostService {
	
	var error: NSError
	
	init(error: NSError) {
		self.error = error
	}
	
	func getAllPosts() throws -> [Post] {
		throw error
	}
	
	func update(_ posts: [Post]) throws {
		
	}
}

class PostServiceSpy: PostService {
	
	var posts: [Post]?
	
	func getAllPosts() throws -> [Post] {
		throw NSError(domain: "domain", code: 1, userInfo: nil)
	}
	
	func update(_ posts: [Post]) throws {
		self.posts = posts
	}
}
