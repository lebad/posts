//
//  PostsPresenter.swift
//  Posts
//
//  Created by Andrey Lebedev on 07/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

class PostsPresenter {
	
	weak var view: PostsViewInput?
	weak var loader: LoaderShowable?
	
	private var output: PostsPresenterOutput
	
	private var posts = [Post]()
	
	init(output: PostsPresenterOutput) {
		self.output = output
	}
	
	func didChoose(postAtIndex:Int) {
		let post = posts[postAtIndex]
		output.didChoose(post: post)
	}
}

extension PostsPresenter: PresenterConfigurable {
	
	func configure() {
		
		loader?.startLoading()
		output.didPostsPresenterConfigure()
		
		view?.show(screenTitle: "Posts")
	}
}

extension PostsPresenter: PostsPresentable {
	
	func present(_ posts: [Post]) {
		self.posts = posts
		let postViewModels = self.posts.map { PostViewModel(title: $0.title) }
		view?.show(posts: postViewModels)
	}
}

extension PostsPresenter: ErrorPresentable {
	
	func present(errorMessage: String) {
		view?.show(errorMessage: errorMessage)
	}
	
	func present(warningMessage: String) {
		view?.show(warningMessage: warningMessage)
	}
}
