//
//  Log.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 11.07.2021.
//

import Foundation

enum Log {
    static func error(_ value: Any?) {
        print("🔴 \(String(describing: value))")
    }

    static func debug(_ value: Any?) {
        print("🔵 \(String(describing: value))")
    }
}
