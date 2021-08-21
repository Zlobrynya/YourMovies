//
//  MainDataCollection.swift
//  MainDataCollection
//
//  Created by Nikita Nikitin on 19.08.2021.
//

import Foundation

protocol MainDataCollectionDelegate: AnyObject {
    func trendingMoviesDidSucceed(_ films: [FilmProtocol]?)
    func topMoviesDidSucceed(_ films: [FilmProtocol]?)
}

protocol MainDataCollectionProtocol: AnyObject {
    func fecheAll() async throws

    var delegate: MainDataCollectionDelegate? { get set }
}

final class MainDataCollection: MainDataCollectionProtocol {

    // MARK: - External Dependencies

    private let topRateNetworkClient: TrendingNetworkClientProtocol
    weak var delegate: MainDataCollectionDelegate?

    // MARK: - Lifecycle

    init(topRateNetworkClient: TrendingNetworkClientProtocol = TrendingNetworkClient()) {
        self.topRateNetworkClient = topRateNetworkClient
    }

    // MARK: - Public functions

    func fecheAll() async throws {
        factoryTask(
            operation: topRateNetworkClient.trendingMovies,
            complite: delegate?.trendingMoviesDidSucceed(_:)
        )
        
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
