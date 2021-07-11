//
//  DiContainer.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 11.07.2021.
//

import Foundation

enum DiContainer {
    // swiftlint:disable:next force_unwrapping
    static let endpoints: Endpoints = PlistFactory().plist(forName: "Endpoints")!
    
    // swiftlint:disable:next force_unwrapping
    static let apiKeys: ApiKeys = PlistFactory().plist(forName: "ApiKeys")!
}
