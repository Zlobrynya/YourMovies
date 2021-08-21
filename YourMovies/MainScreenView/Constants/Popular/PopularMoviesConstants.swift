//
//  PopularMoviesConstants.swift
//  PopularMoviesConstants
//
//  Created by Nikita Nikitin on 21.08.2021.
//

import Foundation

struct PopularMoviesConstants: MoviesConstantsProtocol {

    // MARK: - Public properties

    let url: String
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
        language = locale.languageCode ?? "en"
        apiKey = apiKeys.apiKey
        storeImage = endpoints.storeImage
        url = endpoints.mainApi + endpoints.popularMovies
    }
}
