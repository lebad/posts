//
//  CoreDataAPI.swift
//  Posts
//
//  Created by Andrey Lebedev on 10/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import CoreData

protocol MOInitializable {
	init(managedObject: NSManagedObject)
	static var entityName: String { get }
	static var sortKey: String { get }
}

class CoreDataAPI {
	
	var persistentContainer: NSPersistentContainer
	
	init() {
		persistentContainer = NSPersistentContainer(name: "Posts")
		persistentContainer.loadPersistentStores { if $1 != nil { fatalError() } }
		print(NSPersistentContainer.defaultDirectoryURL().absoluteString)
	}
	
	func fetchAllItems<T>() throws -> [T] where T: MOInitializable  {
		
		var items = [T]()
		var itemsError: Error?
		
		let dispatchGroup = DispatchGroup()
		dispatchGroup.enter()
		persistentContainer.performBackgroundTask { context in
			do {
				let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: T.entityName)
				let sortDescriptor = NSSortDescriptor(key: T.sortKey, ascending: true)
				fetchRequest.sortDescriptors = [sortDescriptor]
				let moitems = try context.fetch(fetchRequest)
				items = moitems.map { T(managedObject: $0) }
			}
			catch (let error) {
				itemsError = error
			}
			
			dispatchGroup.leave()
		}
		dispatchGroup.wait()
		
		if let error = itemsError {
			throw error
		}
		
		return items
	}
	
	func update(_ items: [Post]) throws {
		
		var postError: Error?
		
		let dispatchGroup = DispatchGroup()
		dispatchGroup.enter()
		persistentContainer.performBackgroundTask { context in
			
			for item in items where item.id != nil {
				
				let fetchRequest = NSFetchRequest<MOPost>(entityName: "MOPost")
				let predicate = NSPredicate(format: "id == \(item.id!)")
				fetchRequest.predicate = predicate
				let moitems = try! context.fetch(fetchRequest)
				
				// create new item
				if moitems.isEmpty {
					let post = NSEntityDescription.insertNewObject(forEntityName: "MOPost", into: context) as! MOPost
					post.id = Int16(item.id!)
					post.title = item.title
					post.body = item.body
					if let userId = item.userID {
						post.userId = Int16(userId)
					}
				}
				// update item
				else {
					let post = moitems.first!
					post.title = item.title
					post.body = item.body
					if let userId = item.userID {
						post.userId = Int16(userId)
					}
				}
				
				do {
					try context.save()
				} catch (let error) {
					postError = error
				}
			}
			
			dispatchGroup.leave()
		}
		dispatchGroup.wait()
		
		if let error = postError {
			throw error
		}
	}
}
