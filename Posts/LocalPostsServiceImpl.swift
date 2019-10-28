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
		try coreDataAPI.update(items: posts)
	}
}

extension Post: MOInitializable {
	
	init(managedObject: NSManagedObject) {
		guard let mopost = managedObject as? MOPost else {
			fatalError()
		}
		id = Int(mopost.id)
		if let userId = mopost.user?.id {
			userID = Int(userId)
		} else {
			userID = -1
		}
		
		title = mopost.title ?? ""
		body = mopost.body ?? ""
	}
	
	static var sortKey: String {
		return "id"
	}
	
	static var entityName: String {
		let cell = motype
		return String(describing: cell)
	}
	
	static var motype: NSManagedObject.Type {
		return MOPost.self
	}
}

extension Post: MOConstructable {
	
	static var constructableEntityName: String {
		let cell = motype
		return String(describing: cell)
	}
	
	static var constructableMOtype: NSManagedObject.Type {
		return MOPost.self
	}
	
	var predicateFormat: String {
		return "id == \(self.id)"
	}
	
	func createMOFrom(context: NSManagedObjectContext) -> NSManagedObject {
		let post = NSEntityDescription.insertNewObject(forEntityName: "MOPost", into: context) as! MOPost
		post.id = Int16(self.id)
		post.title = self.title
		post.body = self.body
		post.userId = Int16(self.userID)
		return post
	}
	
	func update(mo: inout NSManagedObject) {
		let managedObject = mo as! MOPost
		managedObject.title = self.title
		managedObject.body = self.body
		managedObject.userId = Int16(self.userID)
	}
}
