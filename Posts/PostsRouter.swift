//
//  PostsRouter.swift
//  Posts
//
//  Created by Andrey Lebedev on 07/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import UIKit

class PostsRouter {
	
	private var window: UIWindow
	private var assembly: PostsAssembly
	private weak var navVC: UINavigationController?
	private var postInfoVC: UIViewController?
	
	init(window: UIWindow, assembly: PostsAssembly) {
		self.window = window
		self.assembly = assembly
	}
	
	func routeToPosts() {
		let viewController = self.assembly.postsViewController()
		let navVC = UINavigationController(rootViewController: viewController)
		self.navVC = navVC
		window.rootViewController = navVC
		window.makeKeyAndVisible()
	}
	
	func preparePostInfoRouting() {
		self.postInfoVC = self.assembly.postInfoViewController()
	}
	
	func routeToPostInfo() {
		guard let postInfoViewController = self.postInfoVC else {
			return
		}
		navVC?.pushViewController(postInfoViewController, animated: true)
		self.postInfoVC = nil
	}
}
