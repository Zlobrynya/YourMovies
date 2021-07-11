//
//  PlistFactory.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 11.07.2021.
//

import Foundation

protocol PlistFactoryProtocol {
    func plist<T: Decodable>(forName name: String) -> T?
}

struct PlistFactory: PlistFactoryProtocol {

    // MARK: - External Dependencies

    private var bundle: BundleProtocol
    private var decoder: PropertyListDecoderProtocol

    // MARK: - Lifecycle

    init(bundle: BundleProtocol = Bundle.main, decoder: PropertyListDecoderProtocol = PropertyListDecoder()) {
        self.bundle = bundle
        self.decoder = decoder
    }

    // MARK: - Public functions

    func plist<T: Decodable>(forName name: String) -> T? {
        guard
            let url = bundle.url(forResource: name, withExtension: "plist"),
            let data = try? Data(contentsOf: url)
        else { return nil }
        return try? decoder.decode(T.self, from: data)
    }
}
