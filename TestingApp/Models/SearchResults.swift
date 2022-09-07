//
//  SearchResults.swift
//  TestingApp
//
//  Created by мак on 06.09.2022.
//

import Foundation

struct SearchResults: Decodable {
    let total: Int
    let results: [UnsplashPhoto]
}

struct UnsplashPhoto: Decodable {
    let width: Int
    let height: Int
    let id: String
    let urls: [URLType.RawValue:String]
}

enum URLType: String {
    case raw
    case full
    case regular
    case small
    case thumb
}

struct IdResults: Decodable {
    let created_at: String
    let downloads: Int
    let location: Location
    let user: User
    let urls: [URLType.RawValue:String]
    let width: Int
    let height: Int
}

struct Location: Decodable {
    let city: String?
    let country: String?
    let position: Position
}

struct Position: Decodable {
    let latitude: Float?
    let longitude: Float?
}

struct User: Decodable {
    let username: String
    let name: String
}
