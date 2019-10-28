//
//  PostsInteractor.swift
//  Posts
//
//  Created by Andrey Lebedev on 09/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

class PostsInteractor {
	
	weak var output: PostsInteractorOutput?
	
	private var reachabilityService: ReachabiltyService
	private var postRemoteService: PostService
	private var postLocalService: PostService
	private var userService: UserService
	private var commentsService: CommentsService
	
	init(reachabilityService: ReachabiltyService,
		 postRemoteService: PostService,
		 postLocalService: PostService,
		 userService: UserService,
		 commentsService: CommentsService) {
		self.reachabilityService = reachabilityService
		self.postRemoteService = postRemoteService
		self.postLocalService = postLocalService
		self.userService = userService
		self.commentsService = commentsService
	}
}

extension PostsInteractor: PostsInteractorInput {
	
	func executePosts() {
		
		let isConnectionReachable = reachabilityService.checkReachable()
		guard isConnectionReachable else {
			getLocalPostsAndReturnOrReturnErrorMessage()
			return
		}
		getRemotePostsUpdateLocallyAndReturnOrReturnErrorMessage()
	}
	
	func executePostInfo(post: Post) {
		do {
			if let user = try userService.getUserFor(id: post.userID) {
				output?.didReceive(user)
			}
			let comments = try commentsService.getComments(postId: post.id)
			output?.didReceive(comments)
		}
		catch (let error) {
			print("Post info error occured \(error)")
		}
	}
	
	private func getLocalPostsAndReturnOrReturnErrorMessage() {
		do {
			let posts = try postLocalService.getAllPosts()
			guard !posts.isEmpty else {
				output?.didReceive(warningMessage:"Sorry. Unfortunately there is no internet connection and local stored data")
				return
			}
			output?.didReceive(posts)
		}
		catch (let error) {
			output?.didReceive(errorMessage:error.localizedDescription)
		}
	}
	
	private func getRemotePostsUpdateLocallyAndReturnOrReturnErrorMessage() {
		do {
			let posts = try postRemoteService.getAllPosts()
			try postLocalService.update(posts)
			output?.didReceive(posts)
		}
		catch (let error) {
			output?.didReceive(errorMessage:error.localizedDescription)
		}
	}
}
