//
//  CommentsService.swift
//  Posts
//
//  Created by Andrey Lebedev on 16/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

protocol CommentsService: AnyObject {
	func getComments(postId: Int) throws -> [Comment]
}
