//
//  ReachabilityServiceImpl.swift
//  Posts
//
//  Created by Andrey Lebedev on 09/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation
import SystemConfiguration

class ReachabilityServiceImpl {
	
	private let reachability = SCNetworkReachabilityCreateWithName(nil, "www.jsonplaceholder.typicode.com")
	
}

extension ReachabilityServiceImpl: ReachabiltyService {
	
	func checkReachable() -> Bool {
		
		var flags = SCNetworkReachabilityFlags()
		SCNetworkReachabilityGetFlags(reachability!, &flags)
		
		let isReachable = flags.contains(.reachable)
		let needsConnection = flags.contains(.connectionRequired)
		let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
		let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)

		return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
	}
}
