//
//  TrendingNetworkClient.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 17.07.2021.
//

import Foundation
import NetworkFramework

protocol TrendingNetworkClientProtocol {
    func trendingMovies() async throws -> [FilmProtocol]?
}

struct TrendingNetworkClient: TrendingNetworkClientProtocol {

    // MARK: - External Dependencies

    private let networkService: NetworkServiceProtocol
    private let constants: MoviesConstantsProtocol
    
    // MARK: - Lifecycle

    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        constants: MoviesConstantsProtocol = TrendingConstants()
    ) {
        self.networkService = networkService
        self.constants = constants
    }

    // MARK: - Public functions

    func trendingMovies() async throws -> [FilmProtocol]? {
        guard let url = URL(string: constants.url) else { throw NetworkingError.emptyResponse }
        let parameters = GeneralParameters(apiKey: constants.apiKey, language: constants.language)
        let films = try await networkService.get(
            forModel: ResponceFilms.self,
            forUrl: url,
            withParameters: parameters,
            andHeaders: nil
        )?.results
        guard var films = films else { return nil }
        films = films.updatePath(withStoreImageUrl: constants.storeImage)
        return films
    }
}