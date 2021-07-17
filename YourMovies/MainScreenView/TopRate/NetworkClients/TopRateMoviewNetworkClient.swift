//
//  TopRateMoviewNetworkClient.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 17.07.2021.
//

import Foundation
import NetworkFramework

protocol TopRateMoviewNetworkClientProtocol {
    func topRate() async throws -> [Film]?
}

struct TopRateMoviewNetworkClient: TopRateMoviewNetworkClientProtocol {

    // MARK: - External Dependencies

    private let networkService: NetworkServiceProtocol
    private let constants: TopRateConstantsProtocol
    
    // MARK: - Lifecycle

    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        constants: TopRateConstantsProtocol = TopRateConstants()
    ) {
        self.networkService = networkService
        self.constants = constants
    }

    // MARK: - Public functions

    func topRate() async throws -> [Film]? {
        guard let url = URL(string: constants.topRatedMovies) else { throw NetworkingError.emptyResponse }
        let parameters = GeneralParameters(apiKey: constants.apiKey, language: constants.language)
        return try await networkService.get(
            forModel: ResponceFilms.self,
            forUrl: url,
            withParameters: parameters,
            andHeaders: nil
        )?.results
    }
}
