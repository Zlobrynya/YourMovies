//
//  ImageCache.swift
//  ImageCache
//
//  Created by Nikita Nikitin on 18.07.2021.
//

import Foundation
import UIKit

enum ImageCacheError: LocalizedError {
    case couldNotDecode
    
    var errorDescription: String? {
        switch self {
        case .couldNotDecode: return "Could not decode image to data."
        }
    }
}

protocol ImageCacheProtocol {
    func save(image: UIImage, for fileName: String)
    func get(for fileName: String) -> UIImage?
}

struct ImageCache: ImageCacheProtocol {

    // MARK: - External Dependencies

    private let dataProvider: DirectoryProviderProtocol

    // MARK: - Lifecycle

    init(dataProvider: DirectoryProviderProtocol = DirectoryProvider()) {
        self.dataProvider = dataProvider
    }

    // MARK: - Public functions

    func save(image: UIImage, for fileName: String) {
        do {
            let cacheDirectory = try dataProvider.cacheDirectory(with: fileName)
            guard let data = image.pngData() else { throw ImageCacheError.couldNotDecode }
            try cacheDirectory.save(data: data, to: fileName)
        } catch {
            Log.error(error)
        }
    }

    func get(for fileName: String) -> UIImage? {
        guard
            let cacheDirectory = try? dataProvider.cacheDirectory(with: fileName),
            let data = try? cacheDirectory.data(for: fileName)
        else { return nil }
        return UIImage(data: data)
    }
}
