//
//  PostsInteractorTests.swift
//  PostsTests
//
//  Created by Andrey Lebedev on 16/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

@testable import Posts
import XCTest

class PostsInteractorTests: XCTestCase {
	
	var interactor: PostsInteractor!
	var interactorOutput: PostsInteractorOutputSpy!
	
	var posts: [Post] {
		get {
			var posts = [Post]()
			for index in 0..<5 {
				let post = Post(id: index, userID: index, title: "Title\(index)", body: "Body\(index)")
				posts.append(post)
			}
			return posts
		}
	}
	
	override func setUp() {
		super.setUp()
		interactor = PostsInteractor()
		
		interactorOutput = PostsInteractorOutputSpy()
		interactor.output = interactorOutput
	}
	
	override func tearDown() {
		interactorOutput = nil
		interactor = nil
		super.tearDown()
	}
	
	func testExecutePostsWhenConnectionIsNotReachableAndPostsExistShouldReceiveLocalPosts() {
		arrange(isReachableConnection: false)
		arrangeLocal(posts: posts)
		
		interactor.executePosts()
		
		XCTAssertEqual(posts, interactorOutput.posts!)
	}
	
	func testExecutePostsWhenConnectionIsNotReachableAndNoPostsShouldReceiveWarningMessage() {
		arrange(isReachableConnection: false)
		arrangeLocal(posts: [Post]())
		
		interactor.executePosts()
		
		XCTAssertEqual(interactorOutput.warningMessage, "Sorry. Unfortunately there is no internet connection and local stored data")
	}
	
	func testExecutePostsWhenConnectionIsNotReachableAndPostLocalServiceThrowsErrorShouldReceiveErrorMessage() {
		arrange(isReachableConnection: false)
		interactor.postLocalService = arrange(errorText: "ErrorText")
		
		interactor.executePosts()
		
		XCTAssertEqual(interactorOutput.errorMessage, "ErrorText")
	}
	
	func testExecutePostsWhenConnectionIsReachableGetUpdateAndReceivePosts() {
		arrange(isReachableConnection: true)
		arrangeRemote(posts: posts)
		let localService = PostServiceSpy()
		interactor.postLocalService = localService
		
		interactor.executePosts()
		
		XCTAssertEqual(localService.posts, posts)
		XCTAssertEqual(posts, interactorOutput.posts!)
	}
	
	func testExecutePostsWhenConnectionIsReachableAndRemoteServiceThrowsErrorShouldReceiveErrorMessage() {
		arrange(isReachableConnection: true)
		interactor.postRemoteService = arrange(errorText: "ErrorText")
		
		interactor.executePosts()
		
		XCTAssertEqual(interactorOutput.errorMessage, "ErrorText")
	}
	
	// MARK: Helpers
	
	func arrange(isReachableConnection: Bool) {
		let reachabilityService = ReachabilityServiceStub(isReachable: isReachableConnection)
		interactor.reachabilityService = reachabilityService
	}
	
	func arrangeLocal(posts: [Post]) {
		let postLocalService = PostServiceStub(posts: posts)
		interactor.postLocalService = postLocalService
	}
	
	func arrangeRemote(posts: [Post]) {
		let remotePostService = PostServiceStub(posts: posts)
		interactor.postRemoteService = remotePostService
	}
	
	func arrange(errorText: String) -> PostServiceErrorStub {
		let error = NSError(domain: "Domain", code: 1, userInfo: [NSLocalizedDescriptionKey: errorText])
		let postService = PostServiceErrorStub(error: error)
		return postService
	}
}
