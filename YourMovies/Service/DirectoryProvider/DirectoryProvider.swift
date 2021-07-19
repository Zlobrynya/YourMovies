//
//  DirectoryProvider.swift
//  DirectoryProvider
//
//  Created by Nikita Nikitin on 18.07.2021.
//

import Foundation

enum DirectoryProviderError: LocalizedError {
    case getCacheUrlWasFailed
    
    var errorDescription: String? {
        switch self {
        case .getCacheUrlWasFailed: return "Couldn't get a link to the cache directory."
        }
    }
}

protocol DirectoryProviderProtocol {
    func cacheDirectory(with folder: String) throws -> DirectoryProtocol
}

struct DirectoryProvider: DirectoryProviderProtocol {
    
    // MARK: - External Dependencies
    
    private let fileManager: FileManager
    
    // MARK: - Lifecycle
    
    init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }
    
    // MARK: - Public functions
    
    func cacheDirectory(with folder: String) throws -> DirectoryProtocol {
        guard var url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
        else { throw DirectoryProviderError.getCacheUrlWasFailed }
        url.appendPathComponent(folder)
        try fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        return Directory(url: url)
    }
    
}
