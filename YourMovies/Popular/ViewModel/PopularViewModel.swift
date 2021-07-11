//
//  PopularViewModel.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 04.07.2021.
//

import Combine
import Foundation
import NetworkFramework

@MainActor
final class PopularViewModel: ObservableObject {

    // MARK: - Public functions

    @Published var popularFilms: [Film] = []

    // MARK: - External Dependencies

    private let networkService: NetworkServiceProtocol

    // MARK: - Lifecycle

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func fetchFilms(byOffset offset: Int) async {
        guard popularFilms.count - offset == 10 else { return }
        let page = (popularFilms.count / 20) + 1
        await fetchFilms(byPage: page)
    }

    func fetchFilms(byPage page: Int = 1) async {
        guard let url = URL(string: DiContainer.endpoints.popular) else { return }

        let parameter = PopularFilmsParameters(apiKey: DiContainer.apiKeys.apiKey, language: "RU", page: page)
        Log.debug(parameter)
        do {
            guard let response = try await networkService.get(
                forModel: ResponceFilms.self,
                forUrl: url,
                withParameters: parameter
            ) else { return }
            popularFilms.append(contentsOf: response.results)
        } catch {
            print("🔴 \(error)")
        }
    }
}
