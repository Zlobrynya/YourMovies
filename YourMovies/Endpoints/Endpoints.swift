//
//  Endpoints.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 11.07.2021.
//

import Foundation

protocol EndpointsProtocol: Decodable {
    var storeImage: String { get }
    var popular: String { get }
}

struct Endpoints: EndpointsProtocol {
    let storeImage: String
    let popular: String
}
