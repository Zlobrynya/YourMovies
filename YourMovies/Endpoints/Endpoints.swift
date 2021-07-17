//
//  Endpoints.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 11.07.2021.
//

import Foundation

protocol EndpointsProtocol: Decodable {
    var storeImage: String { get }
    var topRatedMovies: String { get }
    var popularMovies: String { get }
    var mainApi: String { get }
}

struct Endpoints: EndpointsProtocol {
    var topRatedMovies: String
    var popularMovies: String
    var mainApi: String
    let storeImage: String
}
