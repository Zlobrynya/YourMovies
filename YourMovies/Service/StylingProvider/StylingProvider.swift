//
//  StylingProvider.swift
//  StylingProvider
//
//  Created by Nikita Nikitin on 19.08.2021.
//

import SwiftUI
import UIKit

protocol StylingProviderProtocol {
    var heightRow: CGFloat { get }
}

final class StylingProvider: ObservableObject, StylingProviderProtocol {
    var heightRow: CGFloat { UIScreen.main.bounds.height / 5.5 }
    var test: CGFloat { UIScreen.main.bounds.width / 3.5 }
    
    var spacing12: CGFloat { 12 }
}
