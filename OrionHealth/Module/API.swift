//
//  API.swift
//  OrionHealth
//
//  Created by Liguo Jiao on 24/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit
import Foundation
import JSONCodable

enum JSONParsingError: Error {
    case convertError
    case parseError
}

typealias JSONFormat = [String: Any]

struct JSONDownloader {
    static func download<T: JSONDecodable>(url: URL, completion: @escaping ([T]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, error)
                return
            }
            do {
                let jsonArray = try data.convertJSON()
                let types: [T] = jsonArray.parseJSON()
                completion(types, nil)
            } catch let error {
                completion(nil, error)
            }
        }.resume()
    }
}

extension URL {
    private static let baseURL = "http://jsonplaceholder.typicode.com"
    static let contacts = URL(string: "\(URL.baseURL)/users")!
}

extension Data {
    func convertJSON() throws -> [JSONFormat] {
        guard let serializedJson = try JSONSerialization.jsonObject(with: self) as? [JSONFormat] else {
            throw JSONParsingError.convertError
        }
        return serializedJson
    }
}

extension Array where Element == JSONFormat {
    func parseJSON<T: JSONDecodable>() -> [T] {
        return flatMap(T.init)
    }
}
