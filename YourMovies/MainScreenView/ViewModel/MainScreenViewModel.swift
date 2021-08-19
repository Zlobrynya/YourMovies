//
//  MainScreenViewModel.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 17.07.2021.
//

import SwiftUI

final class MainScreenViewModel: ObservableObject {
    
    // MARK: - Public properties
    
    @Published var trendingRateMovies: [FilmProtocol]?
    @Published var topRateMovies: [FilmProtocol]?

    // MARK: - External Dependencies
    
    private let topRateNetworkClient: TrendingNetworkClientProtocol
    
    // MARK: - Lifecycle
    
    init(topRateNetworkClient: TrendingNetworkClientProtocol = TrendingNetworkClient()) {
        self.topRateNetworkClient = topRateNetworkClient
    }
    
    // MARK: - Public functions

    @MainActor
    func featchData() async {
        do {
            Task.detached(priority: .medium) {
                self.trendingRateMovies = try await self.topRateNetworkClient.trendingMovies()
                Log.info("Task.detached first \(Thread.current)")
            }
            
            Task.detached(priority: .medium) {
                self.topRateMovies = try await self.topRateNetworkClient.trendingMovies()
                Log.info("Task.detached second \(Thread.current)")
            }
            Log.info("details downl")
        } catch {
            Log.error(error)
        }
    }
    
}
