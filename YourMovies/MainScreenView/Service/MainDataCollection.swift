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

    func fetchAll() async throws
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
    private let upcomingNetworkClient: MoviesNetworkClientProtocol
    private let trendingNetworkClient: MoviesNetworkClientProtocol
    private let popularNetworkClient: MoviesNetworkClientProtocol

    // MARK: - Lifecycle

    init(
        topRateNetworkClient: MoviesNetworkClientProtocol = MoviesNetworkClient(constants: TopRatedMoviesConstants()),
        upcomingNetworkClient: MoviesNetworkClientProtocol = MoviesNetworkClient(constants: UpcomingConstants()),
        trendingNetworkClient: MoviesNetworkClientProtocol = MoviesNetworkClient(constants: TrendingConstants()),
        popularNetworkClient: MoviesNetworkClientProtocol = MoviesNetworkClient(constants: PopularMoviesConstants())
    ) {
        self.topRateNetworkClient = topRateNetworkClient
        self.upcomingNetworkClient = upcomingNetworkClient
        self.trendingNetworkClient = trendingNetworkClient
        self.popularNetworkClient = popularNetworkClient
    }

    // MARK: - Public functions

    func fetchAll() async throws {
        async let trending = trendingNetworkClient.fetchMovies()
        async let upcoming = upcomingNetworkClient.fetchMovies()
        async let topRate = topRateNetworkClient.fetchMovies()
        async let popular = popularNetworkClient.fetchMovies()

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
