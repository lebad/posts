//
//  MOComment+CoreDataProperties.swift
//  Posts
//
//  Created by Andrey Lebedev on 11/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//
//

import Foundation
import CoreData


extension MOComment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOComment> {
        return NSFetchRequest<MOComment>(entityName: "MOComment")
    }

    @NSManaged public var name: String?
    @NSManaged public var body: String?
    @NSManaged public var id: Int16
    @NSManaged public var post: MOPost?

}
