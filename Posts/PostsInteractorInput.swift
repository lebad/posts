//
//  PostsInteractorInput.swift
//  Posts
//
//  Created by Andrey Lebedev on 07/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

protocol PostsInteractorInput: AnyObject {
	func executePosts()
	func executePostInfo(post: Post)
}
