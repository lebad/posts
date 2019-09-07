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
		let flowCoordninator = PostsFlowCoordinator()
		let router = PostsRouter(window, assembly: self)
		flowCoordninator.router = router
		self.coordinator = flowCoordninator
		
		flowCoordninator.interactor = assembleAsyncResolver()
		
		return flowCoordninator
	}
	
	func postsViewController() -> UIViewController {
		let viewController = PostsViewController()
		let presenter = PostsPresenter()
		
		viewController.output = presenter
		presenter.view = viewController
		presenter.loader = viewController
		
		presenter.output = coordinator
		coordinator?.postsPresentable = presenter
		coordinator?.errorPresentable = presenter
		
		return viewController
	}
	
	func postInfoViewController() -> UIViewController {
		let viewConrtroller = PostDetailViewController()
		let presenter = PostDetailPresenter()
		
		viewConrtroller.output = presenter
		presenter.view = viewConrtroller
		presenter.loader = viewConrtroller
		
		coordinator?.postDetailPresenter = presenter
		coordinator?.errorPresentable = presenter
		
		return viewConrtroller
	}
	
	private func assembleAsyncResolver() -> AsyncResolver {
		
		let interactor = PostsInteractor()
		
		let asyncResolver = AsyncResolver()
		asyncResolver.interactor = interactor
		asyncResolver.output = coordinator
		
		let serverAPI = ServerAPI()
		let remotePostsService = RemotePostsServiceImpl(serverAPI: serverAPI)
		interactor.postRemoteService = remotePostsService
		
		let coreDataAPI = CoreDataAPI()
		let localRemoteService = LocalPostsServiceImpl(coreDataAPI)
		interactor.postLocalService = localRemoteService
		
		let remoteUserService = RemoteUserService(serverAPI: serverAPI)
		interactor.userService = remoteUserService
		
		let remoteCommentsService = RemoteCommentsService(serverAPI: serverAPI)
		interactor.commentsService = remoteCommentsService
		
		let reachabilityService = ReachabilityServiceImpl()
		interactor.reachabilityService = reachabilityService
		
		interactor.output = asyncResolver
		
		return asyncResolver
	}
}
