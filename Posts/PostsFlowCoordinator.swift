//
//  PostsFlowCoordinator.swift
//  Posts
//
//  Created by Andrey Lebedev on 07/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

class PostsFlowCoordinator {
	
	var interactor: PostsInteractorInput!
	var router: PostsRouter!
	
	weak var postsPresentable: PostsPresentable!
	weak var errorPresentable: ErrorPresentable!
	
	weak var postDetailPresenter: PostDetailPresenterInput?
}

extension PostsFlowCoordinator: Coordinator {
	
	func start() {
		router.routeToPosts()
	}
}

extension PostsFlowCoordinator: PostsPresenterOutput {
	
	func didPostsPresenterConfigure() {
		interactor.executePosts()
	}
	
	func didChoose(post: Post) {
		interactor.executePostInfo(post: post)
		
		router.preparePostInfoRouting()
		postDetailPresenter?.present(post: post)
		router.routeToPostInfo()
	}
}

extension PostsFlowCoordinator: PostsInteractorOutput {
	
	func didReceive(_ posts: [Post]) {
		postsPresentable.present(posts)
	}
	
	func didReceive(_ user: User) {
		postDetailPresenter?.present(user:user)
	}
	
	func didReceive(_ comments: [Comment]) {
		postDetailPresenter?.present(comments:comments)
	}
	
	func didReceive(errorMessage: String) {
		errorPresentable.present(errorMessage:errorMessage)
	}
	
	func didReceive(warningMessage: String) {
		errorPresentable.present(warningMessage:warningMessage)
	}
}
