//
//  UIViewController+Alert.swift
//  Posts
//
//  Created by Andrey Lebedev on 15/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import UIKit

extension UIViewController {
	func show(alertText: String) {
		let alert = UIAlertController(title: nil, message: alertText, preferredStyle: .alert)
		let action = UIAlertAction(title: "Ok", style: .default)
		alert.addAction(action)
		present(alert, animated: true)
	}
}
