//
//  YourMoviesApp.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 26.06.2021.
//

import SwiftUI

@main
struct YourMoviesApp: App {
    var body: some Scene {
        WindowGroup {
            MainScreenView().withEnvironment()
        }
    }
}
