//
//  PostsAssembly.swift
//  Posts
//
//  Created by Andrey Lebedev on 07/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import UIKit

class PostsAssembly {
	
	private weak var coordinator: PostsFlowCoordinator?
	
	func flowCoordinator(_ window: UIWindow) -> Coordinator {
		
		let router = PostsRouter(window: window, assembly: self)
		let asyncResolver = assembleAsyncResolver()
		
		let coordinator = PostsFlowCoordinator(interactor: asyncResolver, router: router)
		self.coordinator = coordinator
		asyncResolver.output = coordinator
		
		return coordinator
	}
	
	func postsViewController() -> UIViewController {
		
		guard let coordinator = self.coordinator else {
			fatalError()
		}
		
		let presenter = PostsPresenter(output: coordinator)
		let viewController = PostsViewController(output: presenter)
		
		presenter.view = viewController
		presenter.loader = viewController
		
		coordinator.postsPresentable = presenter
		coordinator.errorPresentable = presenter
		
		return viewController
	}
	
	func postInfoViewController() -> UIViewController {
		
		let presenter = PostDetailPresenter()
		let viewConrtroller = PostDetailViewController(output: presenter)
		
		presenter.view = viewConrtroller
		presenter.loader = viewConrtroller
		
		coordinator?.postDetailPresenter = presenter
		coordinator?.errorPresentable = presenter
		
		return viewConrtroller
	}
	
	private func assembleAsyncResolver() -> AsyncResolver {
		
		let reachabilityService = ReachabilityServiceImpl()
		
		let serverAPI = ServerAPI()
		let remotePostsService = RemotePostsServiceImpl(serverAPI: serverAPI)
		
		let coreDataAPI = CoreDataAPI()
		let localRemoteService = LocalPostsServiceImpl(coreDataAPI: coreDataAPI)
		
		let remoteUserService = RemoteUserService(serverAPI: serverAPI)
		
		let remoteCommentsService = RemoteCommentsService(serverAPI: serverAPI)
		
		let interactor = PostsInteractor(reachabilityService: reachabilityService,
										 postRemoteService: remotePostsService,
										 postLocalService: localRemoteService,
										 userService: remoteUserService,
										 commentsService: remoteCommentsService)
		
		let asyncResolver = AsyncResolver(interactor: interactor)
		
		interactor.output = asyncResolver
		
		return asyncResolver
	}
}
