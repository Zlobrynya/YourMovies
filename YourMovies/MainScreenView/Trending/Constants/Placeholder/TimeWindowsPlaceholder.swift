//
//  TimeWindowsPlaceholder.swift
//  TimeWindowsPlaceholder
//
//  Created by Nikita Nikitin on 26.07.2021.
//

import Foundation

protocol TimeWindowsPlaceholderProtocol {
    var value: String { get }
}

struct TimeWindowsPlaceholder: TimeWindowsPlaceholderProtocol {
    var value: String { "{time_window}" }
}
