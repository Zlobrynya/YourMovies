//
//  TopRateConstants.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 17.07.2021.
//

import Foundation

protocol TopRateConstantsProtocol {
    var topRatedMovies: String { get }
    var apiKey: String { get }
    var language: String { get }
}

struct TopRateConstants: TopRateConstantsProtocol {

    // MARK: - Public properties

    let topRatedMovies: String
    let apiKey: String
    let language: String

    // MARK: - Lifecycle

    init(
        endpoints: EndpointsProtocol = DiContainer.endpoints,
        apiKeys: ApiKeysProtocol = DiContainer.apiKeys,
        locale: Locale = Locale.current
    ) {
        language = locale.currencyCode ?? "en"
        apiKey = apiKeys.apiKey
        topRatedMovies = endpoints.mainApi + endpoints.topRatedMovies
    }
}
