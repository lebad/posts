//
//  ErrorPresentable.swift
//  Posts
//
//  Created by Andrey Lebedev on 11/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

protocol ErrorPresentable: AnyObject {
	func present(errorMessage: String)
	func present(warningMessage: String)
}
