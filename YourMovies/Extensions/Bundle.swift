//
//  Bundle.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 11.07.2021.
//

import Foundation

protocol BundleProtocol {
    func url(forResource name: String?, withExtension ext: String?) -> URL?
}

extension Bundle: BundleProtocol {}
