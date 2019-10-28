//
//  PostDetailPresenter.swift
//  Posts
//
//  Created by Andrey Lebedev on 12/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

class PostDetailPresenter {
	
	weak var view: PostDetailViewInput?
	weak var loader: LoaderShowable?
	
	private var post: Post?
}

extension PostDetailPresenter: PresenterConfigurable {
	func configure() {
		
		view?.show(screenTitle: "PostInfo")
		
		guard let postToShow = post else {
				assertionFailure("No content for post detail")
				return
		}
		
		let post = PostDetailViewModel(title: postToShow.title, text: postToShow.body)
		view?.add(post: post)
		
		let commentsTitle = CommentsTitleViewModel(title: "Comments:")
		view?.add(commentsTitle: commentsTitle)
		
		view?.updateInfoContent()
	}
}

extension PostDetailPresenter: PostDetailPresenterInput {
	
	func present(post: Post) {
		self.post = post
	}
	
	func present(user: User) {
		let author = AuthorViewModel(username: user.username, email: user.email)
		view?.add(author: author)
		
		view?.updateInfoContent()
	}
	
	func present(comments: [Comment]) {
		let commentViewModels = comments.map { CommentViewModel(name: $0.name, text: $0.body) }
		view?.show(comments: commentViewModels)
	}
}

extension PostDetailPresenter: ErrorPresentable {
	
	func present(errorMessage: String) {
		view?.show(errorMessage: errorMessage)
	}
	
	func present(warningMessage: String) {
		
	}
}
