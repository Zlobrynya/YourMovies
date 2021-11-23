//
//  LocalizableStringProvider.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 08.08.2021.
//

import SwiftUI

protocol LocalizableStringProviderProtocol {
    var dailyTrendingMovies: String { get }
    var topRatedMovies: String { get }
    var popularMovies: String { get }
    var upcomingMovies: String { get }
}

final class LocalizableStringProvider: LocalizableStringProviderProtocol, ObservableObject {
    var dailyTrendingMovies: String { NSLocalizedString("dailyTrendingMovies", bundle: .main, comment: "") }
    var topRatedMovies: String { NSLocalizedString("topRatedMovies", bundle: .main, comment: "") }
    var popularMovies: String { NSLocalizedString("popularMovies", bundle: .main, comment: "") }
    var upcomingMovies: String { NSLocalizedString("upcomingMovies", bundle: .main, comment: "") }
}
