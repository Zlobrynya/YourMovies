//
//  ImageViewModelFactory.swift
//  ImageViewModelFactory
//
//  Created by Nikita Nikitin on 19.07.2021.
//

import Foundation

protocol ImageViewModelFactoryProtocol {
    func viewModel(with url: URL) -> ImageViewModel
}

struct ImageViewModelFactory: ImageViewModelFactoryProtocol {
    
    // MARK: - Public functions

    func viewModel(with url: URL) -> ImageViewModel {
        ImageViewModel(url: url)
    }
    
}
