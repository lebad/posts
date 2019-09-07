//
//  MOPost+CoreDataProperties.swift
//  Posts
//
//  Created by Andrey Lebedev on 16/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//
//

import Foundation
import CoreData


extension MOPost {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOPost> {
        return NSFetchRequest<MOPost>(entityName: "MOPost")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var userId: Int16
    @NSManaged public var comments: NSSet?
    @NSManaged public var user: MOUser?

}

// MARK: Generated accessors for comments
extension MOPost {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: MOComment)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: MOComment)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)

}
