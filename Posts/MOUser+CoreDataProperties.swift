//
//  MOUser+CoreDataProperties.swift
//  Posts
//
//  Created by Andrey Lebedev on 11/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//
//

import Foundation
import CoreData


extension MOUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOUser> {
        return NSFetchRequest<MOUser>(entityName: "MOUser")
    }

    @NSManaged public var name: String?
    @NSManaged public var userName: String?
    @NSManaged public var id: Int16
    @NSManaged public var posts: NSSet?

}

// MARK: Generated accessors for posts
extension MOUser {

    @objc(addPostsObject:)
    @NSManaged public func addToPosts(_ value: MOPost)

    @objc(removePostsObject:)
    @NSManaged public func removeFromPosts(_ value: MOPost)

    @objc(addPosts:)
    @NSManaged public func addToPosts(_ values: NSSet)

    @objc(removePosts:)
    @NSManaged public func removeFromPosts(_ values: NSSet)

}
