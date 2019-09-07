//
//  PostsServiceImpl.swift
//  Posts
//
//  Created by Andrey Lebedev on 09/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

class RemotePostsServiceImpl {
	let serverAPI: ServerAPI
	
	init(serverAPI: ServerAPI) {
		self.serverAPI = serverAPI
	}
}

extension RemotePostsServiceImpl: PostService {
	
	func getAllPosts() throws -> [Post] {
		let posts = try serverAPI.requestArrayJson("/posts") as [Post]
		return posts
	}
	
	func update(_ posts: [Post]) throws {
		// future implementation
	}
}

extension Post: JsonConvertable {
	
	init(json: [String: Any]) {
		userID = json["userId"] as? Int
		id = json["id"] as? Int
		title = json["title"] as? String
		body = json["body"] as? String
	}
}