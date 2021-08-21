//
//  ResponceFilms.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 05.07.2021.
//

import Foundation

struct ResponceFilms: Decodable {
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    // MARK: - Public properties
    
    let results: [FilmProtocol]
    
    // MARK: - Lifecycle
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decode([Film].self, forKey: .results)
    }
}
