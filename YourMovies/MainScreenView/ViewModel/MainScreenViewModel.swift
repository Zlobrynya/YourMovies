//
//  MainScreenViewModel.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 17.07.2021.
//

import SwiftUI

final class MainScreenViewModel: ObservableObject {
    
    // MARK: - Public properties
    
    @Published var topRateMovies: [Film]?
    
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
            topRateMovies = try await topRateNetworkClient.trendingMovies()
        } catch {
            Log.error(error)
        }
    }
    
}
