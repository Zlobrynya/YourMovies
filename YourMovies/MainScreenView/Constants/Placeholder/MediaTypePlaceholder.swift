//
//  MediaTypePlaceholder.swift
//  MediaTypePlaceholder
//
//  Created by Nikita Nikitin on 26.07.2021.
//

import Foundation

protocol MediaTypePlaceholderProtocol {
    var value: String { get }
}

struct MediaTypePlaceholder: MediaTypePlaceholderProtocol {
    var value: String { "{media_type}" }
}
