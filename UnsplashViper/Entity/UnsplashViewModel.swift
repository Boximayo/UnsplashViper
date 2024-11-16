//
//  UnsplashViewModel.swift
//  UnsplashViper
//
//  Created by Mayo Gonzalez ortega on 16/11/24.
//

import Foundation

// MARK: - UnsplashResponse
struct UnsplashResponse: Codable {
    let total: Int
    let totalPages: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    let id: String
    let description: String?
    let user: User
    let urls: Urls

    enum CodingKeys: String, CodingKey {
        case id
        case description
        case user
        case urls
    }
}

// MARK: - User
struct User: Codable {
    let name: String
    let lastName: String?

    enum CodingKeys: String, CodingKey {
        case name
        case lastName = "last_name"
    }
}

// MARK: - Urls
struct Urls: Codable {
    let regular: String
    let small: String
    let thumb: String
}
