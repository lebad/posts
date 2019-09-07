//
//  RemoteCommentsService.swift
//  Posts
//
//  Created by Andrey Lebedev on 16/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

class RemoteCommentsService: CommentsService {
	
	let serverAPI: ServerAPI
	
	init(serverAPI: ServerAPI) {
		self.serverAPI = serverAPI
	}
	
	func getComments(postId: Int) throws -> [Comment] {
		return try serverAPI.requestArrayJson("/comments?postId=\(postId)") as [Comment]
	}
}

extension Comment: JsonConvertable {
	
	init(json: [String: Any]) {
		id = json["id"] as? Int
		postId = json["postId"] as? Int
		name = json["name"] as? String
		email = json["email"] as? String
		body = json["body"] as? String
	}
}
