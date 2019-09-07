//
//  PostsInteractor.swift
//  Posts
//
//  Created by Andrey Lebedev on 09/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

class PostsInteractor {
	
	weak var output: PostsInteractorOutput!
	
	var reachabilityService: ReachabiltyService!
	var postRemoteService: PostService!
	var postLocalService: PostService!
	var userService: UserService!
	var commentsService: CommentsService!
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
			if let userId = post.userID,
				let user = try userService.getUserFor(id: userId) {
				output.didReceive(user)
			}
			if let postId = post.id {
				let comments = try commentsService.getComments(postId: postId)
				output.didReceive(comments)
			}
		}
		catch (let error) {
			print("Post info error occured \(error)")
		}
	}
	
	private func getLocalPostsAndReturnOrReturnErrorMessage() {
		do {
			let posts = try postLocalService.getAllPosts()
			guard !posts.isEmpty else {
				output.didReceive(warningMessage:"Sorry. Unfortunately there is no internet connection and local stored data")
				return
			}
			output.didReceive(posts)
		}
		catch (let error) {
			output.didReceive(errorMessage:error.localizedDescription)
		}
	}
	
	private func getRemotePostsUpdateLocallyAndReturnOrReturnErrorMessage() {
		do {
			let posts = try postRemoteService.getAllPosts()
			try postLocalService.update(posts)
			output.didReceive(posts)
		}
		catch (let error) {
			output.didReceive(errorMessage:error.localizedDescription)
		}
	}
}
