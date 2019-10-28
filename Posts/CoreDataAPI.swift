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

protocol MOConstructable {
	static var constructableEntityName: String { get }
	static var constructableMOtype: NSManagedObject.Type { get }
	var predicateFormat: String { get }
	func createMOFrom(context: NSManagedObjectContext) -> NSManagedObject
	func update(mo: inout NSManagedObject)
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
	
	func update<T>(items: [T]) throws where T: MOConstructable {
		
		var postError: Error?
		
		let dispatchGroup = DispatchGroup()
		dispatchGroup.enter()
		persistentContainer.performBackgroundTask { context in
			
			for item in items {
				
				let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: T.constructableEntityName)
				let predicate = NSPredicate(format: item.predicateFormat)
				fetchRequest.predicate = predicate
				let moitems = try! context.fetch(fetchRequest)
				
				// create new item
				if moitems.isEmpty {
					let _ = item.createMOFrom(context: context)
				}
				// update item
				else {
					guard var moitem = moitems.first else {
						continue
					}
					item.update(mo: &moitem)
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
