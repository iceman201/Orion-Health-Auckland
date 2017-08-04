//
//  Contact.swift
//  OrionHealth
//
//  Created by Liguo Jiao on 24/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit
import JSONCodable

struct Contact {
    let id: Int
    let name: String?
    let username: String?
    let email: String?
    let address: Address?
    let phone: String?
    let website: String?
    let company: Company?
    
    var nameFirstLetter: String {
        return String(self.name![self.name!.startIndex]).uppercased()
    }
}

struct Address {
    let street: String?
    let suite: String?
    let city: String?
    let zipCode: String?
    let geo: Geo?
}

struct Geo {
    let lat: String?
    let lng: String?
}

struct Company {
    let name: String?
    let catchPhrase: String?
    let bs: String?
}


extension Contact: JSONDecodable {
    init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        id = try decoder.decode("id")
        name = try decoder.decode("name")
        username = try decoder.decode("username")
        email = try decoder.decode("email")
        address = try decoder.decode("address")
        phone = try decoder.decode("phone")
        website = try decoder.decode("website")
        company = try decoder.decode("company")
    }
}

extension Company: JSONDecodable {
    init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        name = try decoder.decode("name")
        catchPhrase = try decoder.decode("catchPhrase")
        bs = try decoder.decode("bs")
    }
}

extension Address: JSONDecodable {
    init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        street = try decoder.decode("street")
        suite = try decoder.decode("suite")
        city = try decoder.decode("city")
        zipCode = try decoder.decode("zipCode")
        geo = try decoder.decode("geo")
    }
}

extension Geo: JSONDecodable {
    init(object: JSONObject) throws {
        let decoder = JSONDecoder(object: object)
        lat = try decoder.decode("lat")
        lng = try decoder.decode("lng")
    }
}
