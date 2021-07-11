//
//  ApiKeys.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 11.07.2021.
//

import Foundation

protocol ApiKeysProtocol: Decodable {
    var apiKey: String { get }
}

struct ApiKeys: ApiKeysProtocol {
    let apiKey: String
}
