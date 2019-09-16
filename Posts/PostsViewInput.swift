//
//  PostsViewInput.swift
//  Posts
//
//  Created by Andrey Lebedev on 05/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

protocol PostsViewInput: AnyObject {
	
	func show(posts: [PostViewModel])
	func show(screenTitle: String)
	func show(errorMessage: String)
	func show(warningMessage: String)
}
