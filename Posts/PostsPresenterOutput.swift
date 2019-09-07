//
//  PostsPresenterOutput.swift
//  Posts
//
//  Created by Andrey Lebedev on 07/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

protocol PostsPresenterOutput: AnyObject {
	func didPostsPresenterConfigure()
	func didChoose(post: Post)
}
