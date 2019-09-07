//
//  ReachabiltyService.swift
//  Posts
//
//  Created by Andrey Lebedev on 09/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

protocol ReachabiltyService: AnyObject {
	func checkReachable() -> Bool
}
