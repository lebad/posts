//
//  ReachabilityServiceStub.swift
//  PostsTests
//
//  Created by Andrey Lebedev on 16/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

@testable import Posts
import Foundation

class ReachabilityServiceStub: ReachabiltyService {
	
	var isReachable: Bool
	
	init(isReachable: Bool) {
		self.isReachable = isReachable
	}
	
	func checkReachable() -> Bool {
		return isReachable
	}
}
