//
//  FilmsNetworkClient.swift
//  FilmsNetworkClient
//
//  Created by Nikita Nikitin on 21.08.2021.
//

import Foundation
import NetworkFramework

protocol MoviesNetworkClientProtocol {
    func fetchMovies() async throws -> [FilmProtocol]?
}

struct MoviesNetworkClient<Constants>: MoviesNetworkClientProtocol where Constants: MoviesConstantsProtocol {

    // MARK: - External Dependencies

    private let networkService: NetworkServiceProtocol
    private let constants: Constants
    
    // MARK: - Lifecycle

    init(
        networkService: NetworkServiceProtocol = NetworkService(),
        constants: Constants
    ) {
        self.networkService = networkService
        self.constants = constants
    }

    // MARK: - Public functions

    func fetchMovies() async throws -> [FilmProtocol]? {
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
