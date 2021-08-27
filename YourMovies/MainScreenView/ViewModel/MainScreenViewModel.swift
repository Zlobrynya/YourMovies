//
//  MainScreenViewModel.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 17.07.2021.
//

import SwiftUI

final class MainScreenViewModel: ObservableObject {

    // MARK: - Public properties

    @Published var trendingRateMovies: [FilmProtocol]?
    @Published var topRateMovies: [FilmProtocol]?
    @Published var upcomingMovies: [FilmProtocol]?
    @Published var popularRateMovies: [FilmProtocol]?

    // MARK: - External Dependencies

    private let mainDataCollection: MainDataCollectionProtocol

    // MARK: - Lifecycle

    init(mainDataCollection: MainDataCollectionProtocol = MainDataCollection()) {
        self.mainDataCollection = mainDataCollection
    }

    // MARK: - Public functions

    func featchData() async {
        do {
            try await mainDataCollection.fecheAll()
            await updateUI()
        } catch {
            Log.error(error)
        }
    }

    @MainActor
    private func updateUI() {
//        withAnimation(.linear(duration: 1)) {
            self.trendingRateMovies = self.mainDataCollection.trendingMovies
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            self.upcomingMovies = self.mainDataCollection.upcomingMovies
            self.popularRateMovies = self.mainDataCollection.popularMovies
            self.topRateMovies = self.mainDataCollection.topRateMovies
//        }
    }

    private func updateUI1() {
        performInMainActor {
            withAnimation(.linear(duration: 1)) {
                self.trendingRateMovies = self.mainDataCollection.trendingMovies
            }
        }
        sleep(1)
        performInMainActor {
            withAnimation(.linear(duration: 1)) {
                self.upcomingMovies = self.mainDataCollection.upcomingMovies
                self.popularRateMovies = self.mainDataCollection.popularMovies
                self.topRateMovies = self.mainDataCollection.topRateMovies
            }
        }
    }

    // MARK: - MainDataCollectionDelegate Conformance

//
//    func trendingMoviesDidSucceed(_ films: [FilmProtocol]?) {
//        performInMainActor {
//            withAnimation(.linear(duration: 1)) {
//                self.trendingRateMovies = films
//            }
//        }
//    }
//
//    func topRatedMoviesDidSucceed(_ films: [FilmProtocol]?) {
//        performInMainActor {
//            self.topRateMovies = films
//        }
//    }
//
//    func upcomingMoviesDidSucceed(_ films: [FilmProtocol]?) {
//        performInMainActor {
//            self.upcomingMovies = films
//        }
//    }
//
//    func popularMoviesDidSucceed(_ films: [FilmProtocol]?) {
//        performInMainActor {
//            self.popularRateMovies = films
//        }
//    }
}
