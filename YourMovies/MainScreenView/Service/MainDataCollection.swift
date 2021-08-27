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
    
    var trendingMovies: [FilmProtocol] { get }
    var upcomingMovies: [FilmProtocol] { get }
    var topRateMovies: [FilmProtocol] { get }
    var popularMovies: [FilmProtocol] { get }

    var delegate: MainDataCollectionDelegate? { get set }

    func fecheAll() async throws
}

final class MainDataCollection: MainDataCollectionProtocol {

    // MARK: - Public properties

    var trendingMovies: [FilmProtocol] = []
    var upcomingMovies: [FilmProtocol] = []
    var topRateMovies: [FilmProtocol] = []
    var popularMovies: [FilmProtocol] = []

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
        async let trending = trendingNetworClient.fetchMovies()
        async let upcoming = upcomingNetworClient.fetchMovies()
        async let topRate = topRateNetworkClient.fetchMovies()
        async let popular = popularNetworClient.fetchMovies()

        let films = try await (trending, upcoming, topRate, popular)
        trendingMovies = films.0 ?? []
        upcomingMovies = films.1 ?? []
        topRateMovies = films.2 ?? []
        popularMovies = films.3 ?? []
    }

    // MARK: - Private functions
//
//    private func factoryTask(
//        operation: @escaping () async throws -> [FilmProtocol]?,
//        complite: (([FilmProtocol]?) -> Void)?
//    ) {
//        Task {
//            do {
//                let films = try await operation()
//                complite?(films)
//            } catch {
//                Log.error(error.localizedDescription)
//            }
//        }
//    }
}
