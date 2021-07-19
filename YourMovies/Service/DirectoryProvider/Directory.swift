//
//  Directory.swift
//  Directory
//
//  Created by Nikita Nikitin on 18.07.2021.
//

import Foundation

protocol DirectoryProtocol {
    func save(data: Data, to fileName: String) throws
    func data(for fileName: String) throws -> Data
}

struct Directory: DirectoryProtocol {

    // MARK: - External Dependencies

    private let url: URL

    // MARK: - Lifecycle

    init(url: URL) {
        self.url = url
    }

    // MARK: - Public functions

    func save(data: Data, to fileName: String) throws {
        let url = url.appendingPathComponent(fileName)
        try data.write(to: url)
    }

    func data(for fileName: String) throws -> Data {
        try Data(contentsOf: url.appendingPathComponent(fileName))
    }
}
