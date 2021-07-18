//
//  ImageViewModel.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 18.07.2021.
//

import SwiftUI
import NetworkFramework

final class ImageViewModel: ObservableObject {

    // MARK: - Public properties

    @Published var image: UIImage?

    // MARK: - External Dependencies

    let url: URL
    
    private let networkService: NetworkServiceProtocol

    // MARK: - Lifecycle

    init(url: URL, networkService: NetworkServiceProtocol = NetworkService()) {
        self.url = url
        self.networkService = networkService
    }

    // MARK: - Public functions

    @MainActor
    func fetchImage() async {
        do {
            guard let data = try await networkService.get(forUrl: url) else { return }
            image = UIImage(data: data)
        } catch {
            Log.error(error)
        }
    }
}
