//
//  StringProvider.swift
//  StringProvider
//
//  Created by Nikita Nikitin on 08.08.2021.
//

import SwiftUI

protocol LocalizableStringProviderProtocol {
    var dailyTrendingMovies: String { get }
    var topRatedMovies: String { get }
}

final class LocalizableStringProvider: LocalizableStringProviderProtocol, ObservableObject {
    var dailyTrendingMovies: String { NSLocalizedString("dailyTrendingMovies", bundle: .main, comment: "") }

    var topRatedMovies: String { NSLocalizedString("topRatedMovies", comment: "") }
}
