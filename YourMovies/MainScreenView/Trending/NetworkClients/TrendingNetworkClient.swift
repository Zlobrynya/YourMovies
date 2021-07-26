//
//  TrendingNetworkClient.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 17.07.2021.
//

import Foundation
import NetworkFramework

protocol TrendingNetworkClientProtocol {
    func trendingMovies() async throws -> [Film]?
}

struct TrendingNetworkClient: TrendingNetworkClientProtocol {

    // MARK: - External Dependencies

    private let networkService: NetworkServiceProtocol
    private let constants: TrendingConstantsProtocol
    
    // MARK: - Lifecycle

    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        constants: TrendingConstantsProtocol = TrendingConstants()
    ) {
        self.networkService = networkService
        self.constants = constants
    }

    // MARK: - Public functions

    func trendingMovies() async throws -> [Film]? {
        guard let url = URL(string: constants.trendingMovies) else { throw NetworkingError.emptyResponse }
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
