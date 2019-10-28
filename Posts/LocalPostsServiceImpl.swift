//
//  LocalPostsServiceImpl.swift
//  Posts
//
//  Created by Andrey Lebedev on 11/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation
import CoreData

class LocalPostsServiceImpl {
	
	private let coreDataAPI: CoreDataAPI
	
	init(coreDataAPI: CoreDataAPI) {
		self.coreDataAPI = coreDataAPI
	}
}

extension LocalPostsServiceImpl: PostService {
	
	func getAllPosts() throws -> [Post] {
		let posts = try coreDataAPI.fetchAllItems() as [Post]
		return posts
	}
	
	func update(_ posts: [Post]) throws {
		try coreDataAPI.update(posts)
	}
}

extension Post: MOInitializable {
	
	init(managedObject: NSManagedObject) {
		guard let mopost = managedObject as? MOPost else {
			fatalError()
		}
		id = Int(mopost.id)
		userID = nil
		if let userId = mopost.user?.id {
			userID = Int(userId)
		}
		title = mopost.title
		body = mopost.body
	}
	
	static var sortKey: String {
		get {
			return "id"
		}
	}
	
	static var entityName: String {
		get {
			let cell = motype
			return String(describing: cell)
		}
	}
	
	static var motype: NSManagedObject.Type {
		get {
			return MOPost.self
		}
	}
}
