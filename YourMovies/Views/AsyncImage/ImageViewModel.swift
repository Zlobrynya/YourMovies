//
//  ImageViewModel.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 18.07.2021.
//

import NetworkFramework
import SwiftUI

final class ImageViewModel: ObservableObject {

    // MARK: - Public properties

    @Published var image: UIImage?

    // MARK: - External Dependencies

    let url: String?

    private let networkService: NetworkServiceProtocol
    private let imageCache: ImageCacheProtocol

    // MARK: - Lifecycle

    init(
        url: String?,
        networkService: NetworkServiceProtocol = NetworkService(),
        imageCache: ImageCacheProtocol = ImageCache()
    ) {
        self.url = url
        self.networkService = networkService
        self.imageCache = imageCache
    }

    // MARK: - Public functions

    @MainActor
    func fetchImage() async {
        guard let url = url, let url = URL(string: url) else { return }
        
        let fileName = url.lastPathComponent.replacingOccurrences(of: ".jpg", with: "")

        if let image = imageCache.get(for: fileName) {
            self.image = image
        } else {
            do {
                guard let data = try await networkService.get(forUrl: url) else { return }
                image = UIImage(data: data)
                guard let image = image else { return }
                imageCache.save(image: image, for: fileName)
            } catch {
                Log.error(error)
            }
        }
    }
}
