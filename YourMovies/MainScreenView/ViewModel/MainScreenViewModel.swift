//
//  MainScreenViewModel.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 17.07.2021.
//

import SwiftUI

final class MainScreenViewModel: ObservableObject, MainDataCollectionDelegate {

    // MARK: - Public properties

    @Published var topRateMovies: [FilmProtocol]?
    @Published var upcomingMovies: [FilmProtocol]?
    @Published var popularRateMovies: [FilmProtocol]?
    @Published var trendingRateMovies: [FilmProtocol]?

    // MARK: - External Dependencies

    private let mainDataCollection: MainDataCollectionProtocol

    // MARK: - Lifecycle

    init(mainDataCollection: MainDataCollectionProtocol = MainDataCollection()) {
        self.mainDataCollection = mainDataCollection

        self.mainDataCollection.delegate = self
    }

    // MARK: - Public functions

    func featchData() {
        mainDataCollection.fecheAll()
    }

    // MARK: - MainDataCollectionDelegate Conformance

    func trendingMoviesDidSucceed(_ films: [FilmProtocol]?) {
        performInMainActor {
            withAnimation(.linear(duration: 1)) {
                self.trendingRateMovies = films
            }
        }
    }

    func topRatedMoviesDidSucceed(_ films: [FilmProtocol]?) {
        performInMainActor {
            self.topRateMovies = films
        }
    }

    func upcomingMoviesDidSucceed(_ films: [FilmProtocol]?) {
        performInMainActor {
            self.upcomingMovies = films
        }
    }

    func popularMoviesDidSucceed(_ films: [FilmProtocol]?) {
        performInMainActor {
            self.popularRateMovies = films
        }
    }
}
