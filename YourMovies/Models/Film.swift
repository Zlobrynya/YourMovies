//
//  Films.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 05.07.2021.
//

import Foundation
import Metal

protocol FilmProtocol: Decodable {
    var id: Int { get }
    var title: String { get }
    var posterPath: String? { get }
    var backdropPath: String? { get }
}

struct Film: FilmProtocol, Hashable {
    
    private enum CodeKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    // MARK: - Public functions

    let id: Int
    let title: String
    let posterPath: String?
    let backdropPath: String?
    
    // MARK: - Lifecycle
    
    init(id: Int, title: String, posterPath: String?, backdropPath: String?) {
        self.title = title
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.id = id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodeKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        posterPath = try? container.decode(String.self, forKey: .posterPath)
        backdropPath = try? container.decode(String.self, forKey: .backdropPath)
    }
    
}