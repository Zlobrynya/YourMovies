//
//  PopularViewModel.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 04.07.2021.
//

import Combine
import Foundation
import NetworkFramework

final class PopularViewModel: ObservableObject {
    
    // MARK: - Public functions

    @Published var popularFilms: [Film] = []

    // MARK: - External Dependencies

    private let networkService: NetworkServiceProtocol

    // MARK: - Lifecycle

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func fetchFilms() async {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular") else { return }

        let parameter = PopularFilmsParameters(apiKey: "b68988dea30b5d9064f62c20d3363101", language: "RU")

        do {
            guard let response = try await networkService.get(
                forModel: ResponceFilms.self,
                forUrl: url,
                withParameters: parameter
            ) else { return }
            popularFilms = response.results
        } catch {
            print("🔴 \(error)")
        }
    }
}
