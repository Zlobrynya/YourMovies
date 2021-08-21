//
//  MainDataCollection.swift
//  MainDataCollection
//
//  Created by Nikita Nikitin on 19.08.2021.
//

import Foundation

protocol MainDataCollectionDelegate: AnyObject {
    func trendingMoviesDidSucceed(_ films: [FilmProtocol]?)
    func topRatedMoviesDidSucceed(_ films: [FilmProtocol]?)
    func upcomingMoviesDidSucceed(_ films: [FilmProtocol]?)
    func popularMoviesDidSucceed(_ films: [FilmProtocol]?)
}

protocol MainDataCollectionProtocol: AnyObject {
    func fecheAll() async throws

    var delegate: MainDataCollectionDelegate? { get set }
}

final class MainDataCollection: MainDataCollectionProtocol {

    // MARK: - External Dependencies

    weak var delegate: MainDataCollectionDelegate?
    
    private let topRateNetworkClient: MoviesNetworkClientProtocol
    private let upcomingNetworClient: MoviesNetworkClientProtocol
    private let trendingNetworClient: MoviesNetworkClientProtocol
    private let popularNetworClient: MoviesNetworkClientProtocol

    // MARK: - Lifecycle

    init(
        topRateNetworkClient: MoviesNetworkClientProtocol = MoviesNetworkClient(constants: TopRatedMoviesConstants()),
        upcomingNetworClient: MoviesNetworkClientProtocol = MoviesNetworkClient(constants: UpcomingConstants()),
        trendingNetworClient: MoviesNetworkClientProtocol = MoviesNetworkClient(constants: TrendingConstants()),
        popularNetworClient: MoviesNetworkClientProtocol = MoviesNetworkClient(constants: PopularMoviesConstants())
    ) {
        self.topRateNetworkClient = topRateNetworkClient
        self.upcomingNetworClient = upcomingNetworClient
        self.trendingNetworClient = trendingNetworClient
        self.popularNetworClient = popularNetworClient
    }

    // MARK: - Public functions

    func fecheAll() async throws {
        factoryTask(operation: topRateNetworkClient.fetchMovies, complite: delegate?.topRatedMoviesDidSucceed(_:))
        factoryTask(operation: upcomingNetworClient.fetchMovies, complite: delegate?.upcomingMoviesDidSucceed(_:))
        factoryTask(operation: trendingNetworClient.fetchMovies, complite: delegate?.trendingMoviesDidSucceed(_:))
        factoryTask(operation: popularNetworClient.fetchMovies, complite: delegate?.popularMoviesDidSucceed(_:))
    }

    // MARK: - Private functions

    private func factoryTask(
        operation: @escaping () async throws -> [FilmProtocol]?,
        complite: (([FilmProtocol]?) -> Void)?
    ) {
        Task {
            do {
                let films = try await operation()
                complite?(films)
            } catch {
                Log.error(error.localizedDescription)
            }
        }
    }
}
