//
//  PropertyListDecoder.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 11.07.2021.
//

import Foundation

protocol PropertyListDecoderProtocol {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}

extension PropertyListDecoder: PropertyListDecoderProtocol {}
