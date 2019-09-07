//
//  PostsInteractorOutput.swift
//  Posts
//
//  Created by Andrey Lebedev on 07/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

protocol PostsInteractorOutput: AnyObject {
	func didReceive(_ posts: [Post])
	func didReceive(_ user: User)
	func didReceive(_ comments: [Comment])
	func didReceive(errorMessage: String)
	func didReceive(warningMessage: String)
}
