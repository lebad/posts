//
//  ServerAPI.swift
//  Posts
//
//  Created by Andrey Lebedev on 07/09/2019.
//  Copyright © 2019 andrey. All rights reserved.
//

import Foundation

protocol JsonConvertable {
	init(json: [String: Any])
}

class ServerAPI {
	
	private let baseURLString = "https://jsonplaceholder.typicode.com"
	
	private var dataTask: URLSessionDataTask?
	
	func requestArrayJson<T>(_ urlString: String) throws -> [T] where T: JsonConvertable {
		
		let result = request(urlString: urlString)
		switch result {
		case .success(let jsonData):
			
			var items = [T]()
			if let jsonArray = jsonData as? [[String: Any]] {
				items = jsonArray.map{ T(json: $0) }
			}
			else if let rootJson = jsonData as? [String: Any] {
				items = [T(json: rootJson)]
			}
			else {
				throw NSError(domain: "", code: -1, userInfo: nil)
			}
			return items
			
		case .failure(let error):
			throw error
		}
	}
	
	private func request(urlString: String) -> Result<Any, Error> {
		
		let finalURLString = baseURLString + urlString
		guard let finalURL = URL(string: finalURLString) else {
			return .failure(NSError(domain: "", code: -1, userInfo: nil))
		}
		
		var data: Data?
		var response: URLResponse?
		var error: Error?
		
		dataTask?.cancel()
		let semaphore = DispatchSemaphore(value: 0);
		self.dataTask = URLSession.shared.dataTask(with: finalURL) {
			data = $0
			response = $1
			error = $2
			semaphore.signal()
		}
		dataTask?.resume()
		_ = semaphore.wait(timeout: .distantFuture)
		
		guard let dataResponse = data,
			let httpresponse = response as? HTTPURLResponse,
			httpresponse.statusCode == 200 else {
				return .failure(NSError(domain: "", code: -1, userInfo: nil))
		}
		
		guard error == nil else {
			return .failure(error!)
		}
		
		// !!LOG!!
		if let dataString = String(bytes: dataResponse, encoding: .utf8) {
			print(dataString)
		}
		
		do {
			let jsonData = try JSONSerialization.jsonObject(with: dataResponse, options: [])
			return .success(jsonData)
			
		} catch let jsonError {
			return .failure(jsonError)
		}
	}
}
