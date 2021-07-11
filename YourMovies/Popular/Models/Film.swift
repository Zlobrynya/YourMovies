//
//  Films.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 05.07.2021.
//

import Foundation
import Metal

protocol FilmProtocol: Decodable, Hashable {
    var title: String { get }
    var posterPath: String { get }
}

struct Film: FilmProtocol {
    
    private enum CodeKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
    }
    
    // MARK: - Public functions

    let title: String
    let posterPath: String
    
    // MARK: - Lifecycle
    
    init(title: String, posterPath: String) {
        self.title = title
        self.posterPath = posterPath
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodeKeys.self)
        title = try container.decode(String.self, forKey: .title)
        posterPath = try container.decode(String.self, forKey: .posterPath)
    }
    
}
