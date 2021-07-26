//
//  TopRateConstants.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 17.07.2021.
//

import Foundation

protocol TrendingConstantsProtocol {
    var trendingMovies: String { get }
    var storeImage: String { get }
    var language: String { get }
    var apiKey: String { get }
}

struct TrendingConstants: TrendingConstantsProtocol {

    // MARK: - Public properties

    let trendingMovies: String
    let storeImage: String
    let language: String
    let apiKey: String

    // MARK: - Lifecycle

    init(
        endpoints: EndpointsProtocol = DiContainer.endpoints,
        apiKeys: ApiKeysProtocol = DiContainer.apiKeys,
        locale: Locale = Locale.current,
        mediaTypePlaceholder: MediaTypePlaceholderProtocol = MediaTypePlaceholder(),
        timeWindowsPlaceholder: TimeWindowsPlaceholderProtocol = TimeWindowsPlaceholder()
    ) {
        language = locale.currencyCode ?? "en"
        apiKey = apiKeys.apiKey
        storeImage = endpoints.storeImage
        trendingMovies = endpoints.mainApi + endpoints.trending
            .replacingOccurrences(of: mediaTypePlaceholder.value, with: TrendingMediaType.movie.rawValue)
            .replacingOccurrences(of: timeWindowsPlaceholder.value, with: TrendingTimeType.day.rawValue)
    }
}
