//
//  RemoteUserService.swift
//  Posts
//
//  Created by Andrey Lebedev on 15/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

class RemoteUserService: UserService {
	
	let serverAPI: ServerAPI
	
	init(serverAPI: ServerAPI) {
		self.serverAPI = serverAPI
	}
	
	func getUserFor(id: Int) throws -> User? {
		let users = try serverAPI.requestArrayJson("/users/\(id)") as [User]
		return users.first
	}
}

extension User: JsonConvertable {
	
	init(json: [String: Any]) {
		id = json["id"] as? Int
		name = json["name"] as? String
		username = json["username"] as? String
		email = json["email"] as? String
	}
}
